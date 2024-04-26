import 'package:flutter/material.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/widgets/settings_segments/settings_segments.dart';

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
              ThemeDropdown(),
              SizedBox(height: 16),
              ColorPicker(),
              SizedBox(height: 16),
              TimerFontDropdown(),
              SizedBox(height: 16),
              AlwaysOnTopToggle(),
              AutoAdvanceToggle(),
              SizedBox(height: 16),
              WorkDurationSlider(),
              SizedBox(height: 16),
              ShortBreakDurationSlider(),
              SizedBox(height: 16),
              LongBreakDurationSlider(),
              SizedBox(height: 16),
              LapCountSlider(),
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
