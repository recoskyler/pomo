import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/helpers/hook_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';
import 'package:pomo/widgets/timer/timer_progress.dart';
import 'package:pomo/widgets/timer/timer_text.dart';
import 'package:url_launcher/url_launcher.dart';

enum NotificationType {
  workStart,
  workEnd,
  shortBreakStart,
  shortBreakEnd,
  longBreakStart,
  longBreakEnd,
  startStop,
  nextLap,
  tick,
}

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  Future<void> _notify(
    NotificationType type,
    SettingsState settingsState,
    TimerStatus status,
  ) async {
    if (!settingsState.enableSound) {
      return;
    }

    if ([
          NotificationType.workEnd,
          NotificationType.shortBreakEnd,
          NotificationType.longBreakEnd,
        ].contains(type) &&
        status == TimerStatus.running) {
      return;
    }

    if ([
          NotificationType.workStart,
          NotificationType.shortBreakStart,
          NotificationType.longBreakStart,
        ].contains(type) &&
        status == TimerStatus.stopped) {
      return;
    }

    if (status == TimerStatus.stopped && type != NotificationType.startStop) {
      return;
    }

    final player = AudioPlayer();

    try {
      var sourceFile = '';

      switch (type) {
        case NotificationType.workStart:
          Logger().d('NotificationType.workStart');
          sourceFile = settingsState.customWorkStartSound;
        case NotificationType.workEnd:
          Logger().d('NotificationType.workEnd');
          sourceFile = settingsState.customWorkEndSound;
        case NotificationType.shortBreakStart:
          Logger().d('NotificationType.shortBreakStart');
          sourceFile = settingsState.customShortBreakStartSound;
        case NotificationType.shortBreakEnd:
          Logger().d('NotificationType.shortBreakEnd');
          sourceFile = settingsState.customShortBreakEndSound;
        case NotificationType.longBreakStart:
          Logger().d('NotificationType.longBreakStart');
          sourceFile = settingsState.customLongBreakStartSound;
        case NotificationType.longBreakEnd:
          Logger().d('NotificationType.longBreakEnd');
          sourceFile = settingsState.customLongBreakEndSound;
        case NotificationType.startStop:
          await player.play(AssetSource('sounds/pop.aac'));
        case NotificationType.nextLap:
          Logger().d('NotificationType.nextLap');
          await player.play(AssetSource('sounds/ding_dong.aac'));
        case NotificationType.tick:
          break;
      }

      final source = sourceFile == ''
          ? AssetSource('sounds/ding_dong.aac')
          : DeviceFileSource(sourceFile);

      if (type != NotificationType.startStop &&
          type != NotificationType.tick &&
          type != NotificationType.nextLap &&
          sourceFile != '') {
        await player.play(source);
      }
    } catch (e) {
      await player.stop();
      await player.play(AssetSource('sounds/ding_dong.aac'));
    }
  }

  Map<String, List<int>> _getRGBData(BuildContext context) {
    final timerState = context.read<TimerCubit>().state;
    final color = TimerProgress.getProgressColor(
      status: timerState.status,
      lap: timerState.lap,
      context: context,
    );

    return {
      'rgb': [
        color.red,
        color.green,
        color.blue,
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return MultiBlocListener(
          listeners: [
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                Logger().i('Start/Stop');
                _notify(
                  NotificationType.startStop,
                  settingsState,
                  state.status,
                );
              },
            ),
            // SKIP/NEXT LAP
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) => previous.lap != current.lap,
              listener: (context, state) {
                Logger().i('SKIP/NEXT LAP');
                _notify(
                  NotificationType.nextLap,
                  settingsState,
                  state.status,
                );
              },
            ),
            // TICK
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  current.status == TimerStatus.running &&
                  previous.duration != current.duration,
              listener: (context, state) {
                // Logger().i('Tick web hook');
                _notify(
                  NotificationType.tick,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.tickWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // WORK START
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.work &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Work start web hook');
                _notify(
                  NotificationType.workStart,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.workStartWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // WORK END
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.work &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Work end web hook');
                _notify(
                  NotificationType.workEnd,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.workEndWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // SHORT BREAK START
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.shortBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Short break start web hook');
                _notify(
                  NotificationType.shortBreakStart,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.shortBreakStartWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // SHORT BREAK END
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.shortBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Short break end web hook');
                _notify(
                  NotificationType.shortBreakEnd,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.shortBreakEndWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // LONG BREAK START
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.longBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Long break start web hook');
                _notify(
                  NotificationType.longBreakStart,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.longBreakStartWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            // LONG BREAK END
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.longBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Long break end web hook');
                _notify(
                  NotificationType.longBreakEnd,
                  settingsState,
                  state.status,
                );
                HookHelper.postWebHook(
                  settingsState.longBreakEndWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status &&
                  current.status == TimerStatus.running &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Start timer web hook');
                HookHelper.postWebHook(
                  settingsState.startTimerWebHook,
                  data: _getRGBData(context),
                );

                switch (state.lap) {
                  case TimerLap.work:
                    HookHelper.postWebHook(
                      settingsState.workStartWebHook,
                      data: _getRGBData(context),
                    );
                  case TimerLap.shortBreak:
                    HookHelper.postWebHook(
                      settingsState.shortBreakStartWebHook,
                      data: _getRGBData(context),
                    );
                  case TimerLap.longBreak:
                    HookHelper.postWebHook(
                      settingsState.longBreakStartWebHook,
                      data: _getRGBData(context),
                    );
                }
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status &&
                  current.status == TimerStatus.stopped &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Stop timer web hook');
                HookHelper.postWebHook(
                  settingsState.stopTimerWebHook,
                  data: _getRGBData(context),
                );

                switch (state.lap) {
                  case TimerLap.work:
                    HookHelper.postWebHook(
                      settingsState.workEndWebHook,
                      data: _getRGBData(context),
                    );
                  case TimerLap.shortBreak:
                    HookHelper.postWebHook(
                      settingsState.shortBreakEndWebHook,
                      data: _getRGBData(context),
                    );
                  case TimerLap.longBreak:
                    HookHelper.postWebHook(
                      settingsState.longBreakEndWebHook,
                      data: _getRGBData(context),
                    );
                }
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous != current &&
                  current == const TimerState() &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Reset timer web hook');
                HookHelper.postWebHook(
                  settingsState.resetTimerWebHook,
                  data: _getRGBData(context),
                );
              },
            ),
          ],
          child: TimerView(notify: _notify),
        );
      },
    );
  }
}

class TimerView extends StatefulWidget {
  const TimerView({required this.notify, super.key});

  final Future<void> Function(
    NotificationType type,
    SettingsState settingsState,
    TimerStatus status,
  ) notify;

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer _timer;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      context.read<TimerCubit>().tick(context.read<SettingsCubit>().state);
    });

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _timer.cancel();
    _focusNode.dispose();

    super.dispose();
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse('https://github.com/recoskyler/pomo');

    if (!await launchUrl(uri)) {
      Logger().e('Failed to launch GitHub link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.timer),
        leading: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return IconButton(
              tooltip: state.enableSound ? l10n.mute : l10n.unmute,
              icon: Icon(
                state.enableSound ? Icons.volume_up : Icons.volume_off,
              ),
              onPressed: () => context.read<SettingsCubit>().toggleSound(),
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: l10n.sourceCode,
            icon: const Icon(Icons.code),
            onPressed: _launchUrl,
          ),
          const SizedBox(width: 16),
          IconButton(
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              final duration = DurationHelper.negativeFormat(
                duration: state.duration,
                lap: state.lap,
                settingsState: settingsState,
              );

              return Title(
                title: l10n.timerTitle(duration),
                color: Colors.pinkAccent,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return KeyboardListener(
                          focusNode: _focusNode,
                          autofocus: true,
                          onKeyEvent: (value) {
                            if (value is! KeyUpEvent) {
                              return;
                            }

                            switch (value.logicalKey) {
                              case LogicalKeyboardKey.enter:
                                context.read<TimerCubit>().toggle();
                              case LogicalKeyboardKey.space:
                                context.read<TimerCubit>().toggle();
                              case LogicalKeyboardKey.backspace:
                                context.read<TimerCubit>().reset();
                              case LogicalKeyboardKey.keyR:
                                context.read<TimerCubit>().reset();
                              case LogicalKeyboardKey.keyS:
                                context
                                    .read<TimerCubit>()
                                    .lap(settingsState: state);
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Center(child: TimerProgress()),
                              Center(
                                child: TimerText(
                                  notify: widget.notify,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
