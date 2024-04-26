import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';

class WebHooksToggle extends StatelessWidget {
  const WebHooksToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return BlocBuilder<TimerCubit, TimerState>(
          builder: (context, timerState) {
            return SwitchListTile(
              value: state.enableWebHooks,
              title: Text(l10n.enableWebhooks),
              onChanged: (val) =>
                  context.read<SettingsCubit>().setEnableWebHooks(val),
            );
          },
        );
      },
    );
  }
}
