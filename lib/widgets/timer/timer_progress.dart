import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/helpers/lap_helper.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/cubit/timer_cubit.dart';

class TimerProgress extends StatelessWidget {
  const TimerProgress({super.key});

  Color _getProgressColor({
    required TimerStatus status,
    required TimerLap lap,
    required BuildContext context,
  }) {
    if (status == TimerStatus.running) {
      switch (lap) {
        case TimerLap.work:
          return Theme.of(context).colorScheme.primaryContainer;
        case TimerLap.shortBreak:
          return Theme.of(context).colorScheme.secondary;
        case TimerLap.longBreak:
          return Theme.of(context).colorScheme.tertiary;
      }
    } else {
      return Theme.of(context).colorScheme.secondaryContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: MediaQuery.of(context).size.shortestSide * 0.8,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              final beginVal = DurationHelper.getProgress(
                duration: state.duration - const Duration(seconds: 1),
                lap: state.lap,
                settingsState: settingsState,
              );

              final endVal = DurationHelper.getProgress(
                duration: state.duration,
                lap: state.lap,
                settingsState: settingsState,
              );

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: beginVal, end: endVal),
                curve: Curves.easeOut,
                duration: Durations.medium3,
                builder: (context, value, _) {
                  final nextLap = LapHelper.getNextLap(
                    state.lap,
                    state.lapNumber,
                    settingsState.lapCount,
                  );

                  final color = Color.lerp(
                    _getProgressColor(
                      lap: nextLap,
                      status: state.status,
                      context: context,
                    ),
                    _getProgressColor(
                      lap: state.lap,
                      status: state.status,
                      context: context,
                    ),
                    value,
                  );

                  return CircularProgressIndicator(
                    value: value,
                    color: color,
                    strokeCap: StrokeCap.round,
                    strokeAlign: BorderSide.strokeAlignInside,
                    strokeWidth:
                        MediaQuery.of(context).size.shortestSide * 0.05,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
