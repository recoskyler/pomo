part of 'timer_cubit.dart';

enum TimerStatus {
  running,
  stopped,
}

enum TimerLap {
  work,
  shortBreak,
  longBreak,
}

class TimerState extends Equatable {
  const TimerState({
    this.status = TimerStatus.stopped,
    this.duration = Duration.zero,
    this.lapNumber = 0,
    this.lap = TimerLap.work,
  });

  final TimerStatus status;
  final Duration duration;
  final int lapNumber;
  final TimerLap lap;

  TimerState copyWith({
    TimerStatus Function()? status,
    Duration Function()? duration,
    int Function()? lapNumber,
    TimerLap Function()? lap,
  }) {
    return TimerState(
      status: status != null ? status() : this.status,
      duration: duration != null ? duration() : this.duration,
      lapNumber: lapNumber != null ? lapNumber() : this.lapNumber,
      lap: lap != null ? lap() : this.lap,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        duration,
        status,
        lapNumber,
        lap,
      ];
}
