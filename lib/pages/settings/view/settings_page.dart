import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/helpers/hook_helper.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/timer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: l10n.about,
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeInput(),
              SizedBox(height: 16),
              AlwaysOnTopInput(),
              AutoAdvanceInput(),
              SizedBox(height: 16),
              WorkDurationInput(),
              SizedBox(height: 16),
              ShortBreakDurationInput(),
              SizedBox(height: 16),
              LongBreakDurationInput(),
              SizedBox(height: 16),
              LapCountInput(),
              SizedBox(height: 16),
              WebHooksToggle(),
              WebHooksExpansion(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class WebHooksExpansion extends StatelessWidget {
  const WebHooksExpansion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return ExpansionTile(
          enabled: state.enableWebHooks,
          title: Text(l10n.webhooks),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          shape: const Border(),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            Text(
              l10n.webhooksDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            const TriggerMethodDropdown(),
            const SizedBox(height: 16),
            Text(
              l10n.startWorkWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/start-work',
                border: OutlineInputBorder(),
              ),
              initialValue: state.workStartWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setWorkStartWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.endWorkWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/end-work',
                border: OutlineInputBorder(),
              ),
              initialValue: state.workEndWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setWorkEndWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.startShortBreakWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/start-short',
                border: OutlineInputBorder(),
              ),
              initialValue: state.workStartWebHook,
              onChanged: (value) => context
                  .read<SettingsCubit>()
                  .setShortBreakStartWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.endShortBreakWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/end-short',
                border: OutlineInputBorder(),
              ),
              initialValue: state.shortBreakEndWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setShortBreakEndWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.startLongBreakWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/start-long',
                border: OutlineInputBorder(),
              ),
              initialValue: state.longBreakStartWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setLongBreakStartWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.endLongBreakWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/end-long',
                border: OutlineInputBorder(),
              ),
              initialValue: state.longBreakEndWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setLongBreakEndWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.startTimerWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/start-timer',
                border: OutlineInputBorder(),
              ),
              initialValue: state.startTimerWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setStartTimerWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.stopTimerWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/stop-timer',
                border: OutlineInputBorder(),
              ),
              initialValue: state.stopTimerWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setStopTimerWebHook(value),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.resetTimerWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/reset-timer',
                border: OutlineInputBorder(),
              ),
              initialValue: state.resetTimerWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setResetTimerWebHook(value),
            ),
          ],
        );
      },
    );
  }
}

class ThemeInput extends StatelessWidget {
  const ThemeInput({
    super.key,
  });

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
                l10n.themeMode,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              DropdownButton<ThemeMode>(
                value: state.themeMode,
                isExpanded: true,
                items: [
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.light,
                    child: Text(l10n.light),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.dark,
                    child: Text(l10n.dark),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.system,
                    child: Text(l10n.system),
                  ),
                ],
                onChanged: (val) => context
                    .read<SettingsCubit>()
                    .setThemeMode(val ?? ThemeMode.system),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AlwaysOnTopInput extends StatelessWidget {
  const AlwaysOnTopInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (kIsWeb ||
        (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS)) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SwitchListTile(
          value: state.alwaysOnTop,
          title: Text(l10n.alwaysOnTop),
          subtitle: Text(l10n.requiresRestart),
          onChanged: (val) => context.read<SettingsCubit>().setAlwaysOnTop(val),
        );
      },
    );
  }
}

class AutoAdvanceInput extends StatelessWidget {
  const AutoAdvanceInput({
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
              value: state.autoAdvance,
              title: Text(l10n.autoAdvance),
              subtitle: Text(l10n.autoAdvanceDescription),
              onChanged: timerState.status == TimerStatus.stopped
                  ? (val) => context.read<SettingsCubit>().setAutoAdvance(val)
                  : null,
            );
          },
        );
      },
    );
  }
}

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

class WorkDurationInput extends StatelessWidget {
  const WorkDurationInput({
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

class ShortBreakDurationInput extends StatelessWidget {
  const ShortBreakDurationInput({
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

class LongBreakDurationInput extends StatelessWidget {
  const LongBreakDurationInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SliderInput(
          title: l10n.longBreakDuration,
          value: state.longBreakMinutes,
          onChanged: (val) {
            context.read<SettingsCubit>().setLongBreakMinutes(val.toInt());
            context.read<TimerCubit>().reset();
          },
        );
      },
    );
  }
}

class LapCountInput extends StatelessWidget {
  const LapCountInput({
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

class TriggerMethodDropdown extends StatelessWidget {
  const TriggerMethodDropdown({
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
