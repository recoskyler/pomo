import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/pages/timer/cubit/timer_cubit.dart';

mixin DurationHelper {
  static String format(Duration duration) {
    final negativeSign = duration.isNegative ? '-' : '';

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());

    return '$negativeSign$twoDigitMinutes:$twoDigitSeconds';
  }

  static String negativeFormat({
    required Duration duration,
    required TimerLap lap,
    required SettingsState settingsState,
  }) {
    var negativeDuration = Duration.zero;

    switch (lap) {
      case TimerLap.work:
        negativeDuration = Duration(minutes: settingsState.workMinutes);
      case TimerLap.shortBreak:
        negativeDuration = Duration(minutes: settingsState.shortBreakMinutes);
      case TimerLap.longBreak:
        negativeDuration = Duration(minutes: settingsState.longBreakMinutes);
    }

    final newDuration = negativeDuration - duration;

    return format(newDuration);
  }

  static bool isLapComplete({
    required Duration duration,
    required TimerLap lap,
    required SettingsState settingsState,
  }) {
    if (lap == TimerLap.work) {
      return isWorkComplete(duration, settingsState);
    } else if (lap == TimerLap.shortBreak) {
      return isShortBreakComplete(duration, settingsState);
    } else {
      return isLongBreakComplete(duration, settingsState);
    }
  }

  static bool isWorkComplete(
    Duration duration,
    SettingsState settingsState,
  ) {
    return duration.inSeconds >= settingsState.workMinutes * 60;
  }

  static bool isShortBreakComplete(
    Duration duration,
    SettingsState settingsState,
  ) {
    return duration.inSeconds >= settingsState.shortBreakMinutes * 60;
  }

  static bool isLongBreakComplete(
    Duration duration,
    SettingsState settingsState,
  ) {
    return duration.inSeconds >= settingsState.longBreakMinutes * 60;
  }

  static double getProgress({
    required Duration duration,
    required TimerLap lap,
    required SettingsState settingsState,
  }) {
    if (lap == TimerLap.work) {
      return 1 - (duration.inSeconds / (settingsState.workMinutes * 60));
    } else if (lap == TimerLap.shortBreak) {
      return 1 - (duration.inSeconds / (settingsState.shortBreakMinutes * 60));
    } else {
      return 1 - (duration.inSeconds / (settingsState.longBreakMinutes * 60));
    }
  }
}
