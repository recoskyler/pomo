import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(),
      child: const TimerView(),
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

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      context.read<TimerCubit>().tick();
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  Color _getProgressColor(
      {required TimerStatus status, required TimerLap lap}) {
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
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.square(
                      dimension: MediaQuery.of(context).size.shortestSide * 0.8,
                      child: CircularProgressIndicator(
                        value: DurationHelper.getProgress(
                          duration: state.duration,
                          lap: state.lap,
                        ),
                        color: _getProgressColor(
                          lap: state.lap,
                          status: state.status,
                        ),
                        strokeCap: StrokeCap.round,
                        strokeAlign: BorderSide.strokeAlignInside,
                        strokeWidth:
                            MediaQuery.of(context).size.shortestSide * 0.025,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          state.lap == TimerLap.work
                              ? l10n.lap(((state.lapNumber / 2) + 1).toInt())
                              : state.lap == TimerLap.shortBreak
                                  ? l10n
                                      .shortBreak((state.lapNumber / 2).ceil())
                                  : l10n.longBreak,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.7),
                              ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          DurationHelper.negativeFormat(
                            duration: state.duration,
                            lap: state.lap,
                          ),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 32),
                        Row(
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
                              onPressed: () =>
                                  context.read<TimerCubit>().toggle(),
                              icon: Icon(
                                state.status == TimerStatus.running
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton.filledTonal(
                              onPressed: () => context
                                  .read<TimerCubit>()
                                  .lap(autoAdvance: false),
                              icon: const Icon(Icons.skip_next),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((TimerCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
