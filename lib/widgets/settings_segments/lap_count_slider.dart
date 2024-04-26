import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';
import 'package:pomo/widgets/settings_segments/slider_input.dart';

class LapCountSlider extends StatelessWidget {
  const LapCountSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SliderInput(
          title: l10n.lapCount,
          value: state.lapCount,
          max: 8,
          min: 3,
          onChanged: (val) {
            context.read<SettingsCubit>().setLapCount(val.toInt());
            context.read<TimerCubit>().reset();
          },
        );
      },
    );
  }
}
