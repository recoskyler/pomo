import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/hook_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';

class TriggerMethodSegment extends StatelessWidget {
  const TriggerMethodSegment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.triggerMethod,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return SegmentedButton<TriggerMethod>(
              showSelectedIcon: false,
              segments: TriggerMethod.values
                  .map(
                    (e) => ButtonSegment(
                      value: e,
                      label: Text(
                        e.name.split('.').last.toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
              selected: {state.triggerMethod},
              onSelectionChanged: (val) => context
                  .read<SettingsCubit>()
                  .setTriggerMethod(val.firstOrNull ?? TriggerMethod.post),
            );
          },
        ),
      ],
    );
  }
}
