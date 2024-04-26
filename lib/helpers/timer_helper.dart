import 'package:flutter/material.dart';
import 'package:pomo/pages/settings/settings.dart';
import 'package:pomo/singletons/prefs.dart';
import 'package:pomo/widgets/time_text/time_text.dart';

mixin TimerHelper {
  static Widget buildTimerText({
    required String duration,
    required SettingsState settingsState,
    TextStyle? style,
  }) {
    switch (settingsState.timerFont) {
      case TimerFont.regular:
        return RegularTime(duration: duration, style: style);
      case TimerFont.bold:
        return BoldTime(duration: duration, style: style);
      case TimerFont.fancyMono:
        return FancyMonoTime(duration: duration, style: style);
      case TimerFont.boldMono:
        return BoldMonoTime(duration: duration, style: style);
      case TimerFont.mono:
        return MonoTime(duration: duration, style: style);
      case TimerFont.custom:
        return CustomTime(
          duration: duration,
          style: style,
          fontFamily: settingsState.timerCustomFont,
        );
    }
  }
}
