import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/timer/cubit/timer_cubit.dart';
import 'package:pomo/widgets/action_buttons.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<TimerCubit, TimerState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.lap == TimerLap.work
                ? l10n.lap(((state.lapNumber / 2) + 1).toInt())
                : state.lap == TimerLap.shortBreak
                    ? l10n.shortBreak((state.lapNumber / 2).ceil())
                    : l10n.longBreak,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 24),
          Text(
            DurationHelper.negativeFormat(
              duration: state.duration,
              lap: state.lap,
            ),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 24),
          const ActionButtons(),
        ],
      );
    });
  }
}
