import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/widgets/settings_segments/trigger_method_segment.dart';

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
            const TriggerMethodSegment(),
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
            const SizedBox(height: 16),
            Text(
              l10n.tickWebHookUrl,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'https://example.com/api/v1/webhooks/timer-tick',
                border: OutlineInputBorder(),
              ),
              initialValue: state.tickWebHook,
              onChanged: (value) =>
                  context.read<SettingsCubit>().setTickWebHook(value),
            ),
          ],
        );
      },
    );
  }
}
