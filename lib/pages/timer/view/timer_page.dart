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

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return MultiBlocListener(
          listeners: [
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (!settingsState.enableSound) {
                  return;
                }

                player.play(AssetSource('sounds/pop.aac'));
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) => previous.lap != current.lap,
              listener: (context, state) {
                if (!settingsState.enableSound) {
                  return;
                }

                player.play(AssetSource('sounds/ding_dong.aac'));
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.work &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Work start web hook');
                HookHelper.postWebHook(settingsState.workStartWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.work &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Work end web hook');
                HookHelper.postWebHook(settingsState.workEndWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.shortBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Short break start web hook');
                HookHelper.postWebHook(settingsState.shortBreakStartWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.shortBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Short break end web hook');
                HookHelper.postWebHook(settingsState.shortBreakEndWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  current.lap == TimerLap.longBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Long break start web hook');
                HookHelper.postWebHook(settingsState.longBreakStartWebHook);
              },
            ),
            BlocListener<TimerCubit, TimerState>(
              listenWhen: (previous, current) =>
                  previous.lap != current.lap &&
                  previous.lap == TimerLap.longBreak &&
                  settingsState.enableWebHooks,
              listener: (context, state) {
                Logger().i('Long break end web hook');
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
