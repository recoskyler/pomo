import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';
import 'package:pomo/widgets/settings_segments/slider_input.dart';

class WorkDurationSlider extends StatelessWidget {
  const WorkDurationSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SliderInput(
          title: l10n.workDuration,
          value: state.workMinutes,
          onChanged: (val) {
            context.read<SettingsCubit>().setWorkMinutes(val.toInt());
            context.read<TimerCubit>().reset();
          },
        );
      },
    );
  }
}
