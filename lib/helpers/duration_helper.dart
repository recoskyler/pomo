import 'package:pomo/singletons/prefs.dart';
import 'package:pomo/timer/cubit/timer_cubit.dart';

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
  }) {
    var negativeDuration = Duration.zero;

    switch (lap) {
      case TimerLap.work:
        negativeDuration = Duration(minutes: Prefs.workMinutes);
      case TimerLap.shortBreak:
        negativeDuration = Duration(minutes: Prefs.shortBreakMinutes);
      case TimerLap.longBreak:
        negativeDuration = Duration(minutes: Prefs.longBreakMinutes);
    }

    final newDuration = negativeDuration - duration;

    return format(newDuration);
  }

  static bool isLapComplete({
    required Duration duration,
    required TimerLap lap,
  }) {
    if (lap == TimerLap.work) {
      return isWorkComplete(duration);
    } else if (lap == TimerLap.shortBreak) {
      return isShortBreakComplete(duration);
    } else {
      return isLongBreakComplete(duration);
    }
  }

  static bool isWorkComplete(Duration duration) {
    return duration.inSeconds >= Prefs.workMinutes * 60;
  }

  static bool isShortBreakComplete(Duration duration) {
    return duration.inSeconds >= Prefs.shortBreakMinutes * 60;
  }

  static bool isLongBreakComplete(Duration duration) {
    return duration.inSeconds >= Prefs.longBreakMinutes * 60;
  }

  static Duration get getWorkDuration {
    return Duration(minutes: Prefs.workMinutes);
  }

  static Duration get getShortBreakDuration {
    return Duration(minutes: Prefs.shortBreakMinutes);
  }

  static Duration get getLongBreakDuration {
    return Duration(minutes: Prefs.longBreakMinutes);
  }

  static double getProgress({
    required Duration duration,
    required TimerLap lap,
  }) {
    if (lap == TimerLap.work) {
      return 1 - (duration.inSeconds / (Prefs.workMinutes * 60));
    } else if (lap == TimerLap.shortBreak) {
      return 1 - (duration.inSeconds / (Prefs.shortBreakMinutes * 60));
    } else {
      return 1 - (duration.inSeconds / (Prefs.longBreakMinutes * 60));
    }
  }
}
