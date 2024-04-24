import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  void start() {
    emit(state.copyWith(status: () => TimerStatus.running));
  }

  void stop() {
    emit(state.copyWith(status: () => TimerStatus.stopped));
  }

  void reset() {
    emit(const TimerState());
  }

  void lap({required SettingsState settingsState, bool autoAdvance = true}) {
    emit(
      state.copyWith(
        duration: () => Duration.zero,
        lapNumber: () => (state.lapNumber + 1) % (settingsState.lapCount * 2),
        lap: () {
          if (state.lapNumber == 0) {
            return TimerLap.shortBreak;
          } else if (state.lapNumber == (settingsState.lapCount * 2) - 2) {
            return TimerLap.longBreak;
          } else if (state.lapNumber.isOdd &&
              state.lapNumber < ((settingsState.lapCount * 2) - 1)) {
            return TimerLap.work;
          } else if (state.lapNumber.isEven &&
              state.lapNumber < ((settingsState.lapCount * 2) - 1)) {
            return TimerLap.shortBreak;
          } else {
            return TimerLap.work;
          }
        },
      ),
    );

    if (!autoAdvance) {
      stop();
    }
  }

  /// Adds the given [duration] to the current [TimerState.duration].
  /// If no [duration] is provided, it defaults to 1 second.
  void tick(
    SettingsState settingsState, [
    Duration duration = const Duration(seconds: 1),
  ]) {
    if (state.status != TimerStatus.running) {
      return;
    }

    final newDuration = state.duration + duration;

    if (DurationHelper.isLapComplete(
          duration: newDuration,
          lap: state.lap,
          settingsState: settingsState,
        ) &&
        settingsState.autoAdvance) {
      lap(settingsState: settingsState);

      return;
    } else if (DurationHelper.isLapComplete(
      duration: newDuration,
      lap: state.lap,
      settingsState: settingsState,
    )) {
      stop();
      lap(settingsState: settingsState);

      return;
    }

    emit(state.copyWith(duration: () => newDuration));
  }

  void toggle() {
    if (state.status == TimerStatus.running) {
      stop();
    } else {
      start();
    }
  }
}
