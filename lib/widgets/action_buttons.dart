import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/cubit/timer_cubit.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<TimerCubit, TimerState>(
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
              onPressed: () => context.read<TimerCubit>().toggle(),
              icon: Icon(
                state.status == TimerStatus.running
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
            const SizedBox(width: 16),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                return IconButton.filledTonal(
                  tooltip: l10n.skipLap,
                  onPressed: () =>
                      context.read<TimerCubit>().lap(
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
    );
  }
}
