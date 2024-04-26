import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/helpers/timer_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/cubit/timer_cubit.dart';
import 'package:pomo/widgets/timer/action_buttons.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  IconData _getIcon(TimerLap lap) {
    switch (lap) {
      case TimerLap.work:
        return Icons.work;
      case TimerLap.shortBreak:
        return Icons.free_breakfast;
      case TimerLap.longBreak:
        return Icons.beach_access;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getIcon(state.lap)),
            const SizedBox(height: 16),
            Text(
              state.lap == TimerLap.work
                  ? l10n.lap(((state.lapNumber / 2) + 1).toInt())
                  : state.lap == TimerLap.shortBreak
                      ? l10n.shortBreak((state.lapNumber / 2).ceil())
                      : l10n.longBreak,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                final duration = DurationHelper.negativeFormat(
                  duration: state.duration,
                  lap: state.lap,
                  settingsState: settingsState,
                );

                return TimerHelper.buildTimerText(
                  duration: duration,
                  settingsState: settingsState,
                );
              },
            ),
            const SizedBox(height: 8),
            const ActionButtons(),
          ],
        );
      },
    );
  }
}
