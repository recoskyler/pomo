import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';
import 'package:pomo/widgets/settings_segments/slider_input.dart';

class ShortBreakDurationSlider extends StatelessWidget {
  const ShortBreakDurationSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SliderInput(
          max: 30,
          divisions: 29,
          title: l10n.shortBreakDuration,
          value: state.shortBreakMinutes,
          onChanged: (val) {
            context.read<SettingsCubit>().setShortBreakMinutes(val.toInt());
            context.read<TimerCubit>().reset();
          },
        );
      },
    );
  }
}
