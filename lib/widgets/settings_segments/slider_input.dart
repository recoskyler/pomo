import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/pages/timer/timer.dart';

class SliderInput extends StatelessWidget {
  const SliderInput({
    required this.title,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 60,
    this.divisions = 59,
    this.disableWhileRunning = true,
    super.key,
  });

  final String Function(num minutes) title;
  final int value;
  final double min;
  final double max;
  final int divisions;
  final bool disableWhileRunning;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, timerState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title(value),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Slider(
                value: value.toDouble(),
                min: min,
                max: max,
                divisions: divisions,
                label: value.toString(),
                onChanged: timerState.status == TimerStatus.running &&
                        disableWhileRunning
                    ? null
                    : onChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
