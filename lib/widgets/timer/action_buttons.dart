import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/cubit/timer_cubit.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    super.key,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Durations.long2,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocListener(
      listeners: [
        BlocListener<TimerCubit, TimerState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == TimerStatus.running) {
              controller.forward();
            } else {
              controller.reverse();
            }
          },
        ),
        BlocListener<TimerCubit, TimerState>(
          listenWhen: (previous, current) =>
              previous.duration != current.duration && !controller.isAnimating,
          listener: (context, state) {
            if (state.status == TimerStatus.running && controller.value < 1) {
              controller.reverse();
            } else if (controller.value > 0) {
              controller.forward();
            }
          },
        ),
      ],
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                ),
                tooltip: l10n.reset,
                onPressed: state.status == TimerStatus.running
                    ? null
                    : () => context.read<TimerCubit>().reset(),
                icon: const Icon(Icons.restore),
              ),
              const SizedBox(width: 16),
              IconButton.filled(
                style: IconButton.styleFrom(
                  fixedSize: const Size.square(64),
                  iconSize: 32,
                ),
                tooltip: state.status == TimerStatus.stopped
                    ? l10n.startTimer
                    : l10n.pauseTimer,
                onPressed: () {
                  context.read<TimerCubit>().toggle();
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: animation,
                ),
              ),
              const SizedBox(width: 16),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settingsState) {
                  return IconButton.filledTonal(
                    tooltip: l10n.skipLap,
                    onPressed: () => context.read<TimerCubit>().lap(
                          autoAdvance: false,
                          settingsState: settingsState,
                        ),
                    icon: const Icon(Icons.skip_next),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
