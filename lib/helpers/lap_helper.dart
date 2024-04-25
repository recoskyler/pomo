import 'package:pomo/pages/timer/cubit/timer_cubit.dart';

mixin LapHelper {
  /// Returns the next lap based on the current lap.
  static TimerLap getNextLap(TimerLap lap, int lapNumber, int lapCount) {
    if (lapNumber == 0) {
      return TimerLap.shortBreak;
    } else if (lapNumber == (lapCount * 2) - 2) {
      return TimerLap.longBreak;
    } else if (lapNumber.isOdd && lapNumber < ((lapCount * 2) - 1)) {
      return TimerLap.work;
    } else if (lapNumber.isEven && lapNumber < ((lapCount * 2) - 1)) {
      return TimerLap.shortBreak;
    } else {
      return TimerLap.work;
    }
  }
}
