import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pomo/helpers/hook_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';
import 'package:pomo/widgets/timer/timer_progress.dart';
import 'package:pomo/widgets/timer/timer_text.dart';

enum NotificationType {
  workStart,
  workEnd,
  shortBreakStart,
  shortBreakEnd,
  longBreakStart,
  longBreakEnd,
  startStop,
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

    final player = AudioPlayer();

    try {
      switch (type) {
        case NotificationType.workStart:
          await player
              .play(DeviceFileSource(settingsState.customWorkStartSound));
        case NotificationType.workEnd:
          await player.play(DeviceFileSource(settingsState.customWorkEndSound));
        case NotificationType.shortBreakStart:
          await player
              .play(DeviceFileSource(settingsState.customShortBreakStartSound));
        case NotificationType.shortBreakEnd:
          await player
              .play(DeviceFileSource(settingsState.customShortBreakEndSound));
        case NotificationType.longBreakStart:
          await player
              .play(DeviceFileSource(settingsState.customLongBreakStartSound));
        case NotificationType.longBreakEnd:
          await player
              .play(DeviceFileSource(settingsState.customLongBreakEndSound));
        case NotificationType.startStop:
          await player.play(AssetSource('sounds/pop.aac'));
      }
    } catch (e) {
      await player.stop();
      await player.play(AssetSource('sounds/ding_dong.aac'));
    }
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
                HookHelper.postWebHook(settingsState.workStartWebHook);
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
                HookHelper.postWebHook(settingsState.workEndWebHook);
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
                HookHelper.postWebHook(settingsState.shortBreakStartWebHook);
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
                HookHelper.postWebHook(settingsState.shortBreakEndWebHook);
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
                HookHelper.postWebHook(settingsState.longBreakStartWebHook);
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
                HookHelper.postWebHook(settingsState.longBreakEndWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status &&
                  current.status == TimerStatus.running &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Start timer web hook');
                HookHelper.postWebHook(settingsState.startTimerWebHook);

                switch (state.lap) {
                  case TimerLap.work:
                    HookHelper.postWebHook(settingsState.workStartWebHook);
                  case TimerLap.shortBreak:
                    HookHelper.postWebHook(
                      settingsState.shortBreakStartWebHook,
                    );
                  case TimerLap.longBreak:
                    HookHelper.postWebHook(settingsState.longBreakStartWebHook);
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
                HookHelper.postWebHook(settingsState.stopTimerWebHook);

                switch (state.lap) {
                  case TimerLap.work:
                    HookHelper.postWebHook(settingsState.workEndWebHook);
                  case TimerLap.shortBreak:
                    HookHelper.postWebHook(settingsState.shortBreakEndWebHook);
                  case TimerLap.longBreak:
                    HookHelper.postWebHook(settingsState.longBreakEndWebHook);
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
                HookHelper.postWebHook(settingsState.resetTimerWebHook);
              },
            ),
          ],
          child: const TimerView(),
        );
      },
    );
  }
}

class TimerView extends StatefulWidget {
  const TimerView({super.key});

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
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SafeArea(
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
                      context.read<TimerCubit>().lap(settingsState: state);
                  }
                },
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(child: TimerProgress()),
                    Center(child: TimerText()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
