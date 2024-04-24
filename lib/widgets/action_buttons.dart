import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/timer/cubit/timer_cubit.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              onPressed: state.status == TimerStatus.running
                  ? null
                  : () => context.read<TimerCubit>().reset(),
              icon: const Icon(Icons.restore),
            ),
            const SizedBox(width: 16),
            IconButton.filled(
              onPressed: () => context.read<TimerCubit>().toggle(),
              icon: Icon(
                state.status == TimerStatus.running
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
            const SizedBox(width: 16),
            IconButton.filledTonal(
              onPressed: () =>
                  context.read<TimerCubit>().lap(autoAdvance: false),
              icon: const Icon(Icons.skip_next),
            ),
          ],
        );
      },
    );
  }
}
