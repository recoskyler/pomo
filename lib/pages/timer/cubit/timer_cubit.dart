import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomo/helpers/duration_helper.dart';
import 'package:pomo/helpers/lap_helper.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';
import 'package:pomo/singletons/prefs.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit()
      : super(
          TimerState(
            duration: Prefs.duration,
            status: Prefs.timerStatus,
            lap: Prefs.timerLap,
            lapNumber: Prefs.lapNumber,
          ),
        );

  void start() {
    emit(
      state.copyWith(
        status: () => TimerStatus.running,
      ),
    );

    Prefs.timerStatus = TimerStatus.running;
  }

  void stop() {
    emit(
      state.copyWith(
        status: () => TimerStatus.stopped,
      ),
    );

    Prefs.timerStatus = TimerStatus.stopped;
  }

  void reset() {
    emit(const TimerState());

    Prefs.resetTimer();
  }

  void lap({required SettingsState settingsState, bool autoAdvance = true}) {
    final nextLap = LapHelper.getNextLap(
      state.lap,
      state.lapNumber,
      settingsState.lapCount,
    );

    final nextLapNumber = (state.lapNumber + 1) % (settingsState.lapCount * 2);

    emit(
      state.copyWith(
        duration: () => Duration.zero,
        lapNumber: () => nextLapNumber,
        lap: () => nextLap,
        status: !autoAdvance ? () => TimerStatus.stopped : null,
      ),
    );

    Prefs.timerLap = nextLap;
    Prefs.duration = Duration.zero;
    Prefs.lapNumber = nextLapNumber;
    Prefs.timerStatus = !autoAdvance ? TimerStatus.stopped : state.status;
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

    Prefs.duration = newDuration;
  }

  void toggle() {
    if (state.status == TimerStatus.running) {
      stop();
    } else {
      start();
    }
  }
}
