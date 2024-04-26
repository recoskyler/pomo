import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/timer_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/singletons/prefs.dart';

class TimerFontDropdown extends StatelessWidget {
  const TimerFontDropdown({
    super.key,
  });

  String _fontToName(TimerFont font, S l10n) {
    switch (font) {
      case TimerFont.boldMono:
        return l10n.boldMono;
      case TimerFont.mono:
        return l10n.mono;
      case TimerFont.regular:
        return l10n.regular;
      case TimerFont.fancyMono:
        return l10n.fancyMono;
      case TimerFont.bold:
        return l10n.bold;
      case TimerFont.custom:
        return l10n.custom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.timerFont,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              DropdownButton<TimerFont>(
                value: state.timerFont,
                isExpanded: true,
                items: TimerFont.values
                    .map(
                      (e) => DropdownMenuItem<TimerFont>(
                        value: e,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(_fontToName(e, l10n)),
                            const SizedBox(width: 10),
                            TimerHelper.buildTimerText(
                              duration: '12:34',
                              settingsState: state.copyWith(timerFont: () => e),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) => context
                    .read<SettingsCubit>()
                    .setTimerFont(val ?? TimerFont.boldMono),
              ),
              if (state.timerFont == TimerFont.custom)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      l10n.customFontName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Roboto',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: state.timerCustomFont,
                      onChanged: (value) => context
                          .read<SettingsCubit>()
                          .setTimerCustomFont(value),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
