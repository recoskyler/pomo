part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.alwaysOnTop = false,
    this.autoAdvance = false,
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.lapCount = 4,
    this.themeMode = ThemeMode.system,
    this.workStartWebHook = '',
    this.workEndWebHook = '',
    this.shortBreakStartWebHook = '',
    this.shortBreakEndWebHook = '',
    this.longBreakStartWebHook = '',
    this.longBreakEndWebHook = '',
    this.stateChangeWebHook = '',
    this.startTimerWebHook = '',
    this.stopTimerWebHook = '',
    this.resetTimerWebHook = '',
    this.locale = const Locale('en'),
    this.enableWebHooks = false,
    this.enableSound = true,
  });

  final ThemeMode themeMode;

  final bool alwaysOnTop;
  final bool autoAdvance;
  final bool enableWebHooks;
  final bool enableSound;

  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;

  final int lapCount;

  final String workStartWebHook;
  final String workEndWebHook;
  final String shortBreakStartWebHook;
  final String shortBreakEndWebHook;
  final String longBreakStartWebHook;
  final String longBreakEndWebHook;
  final String stateChangeWebHook;
  final String startTimerWebHook;
  final String stopTimerWebHook;
  final String resetTimerWebHook;

  final Locale locale;

  SettingsState copyWith({
    ThemeMode Function()? themeMode,
    bool Function()? alwaysOnTop,
    bool Function()? autoAdvance,
    bool Function()? enableWebHooks,
    bool Function()? enableSound,
    int Function()? workMinutes,
    int Function()? shortBreakMinutes,
    int Function()? longBreakMinutes,
    int Function()? lapCount,
    String Function()? workStartWebHook,
    String Function()? workEndWebHook,
    String Function()? shortBreakStartWebHook,
    String Function()? shortBreakEndWebHook,
    String Function()? longBreakStartWebHook,
    String Function()? longBreakEndWebHook,
    String Function()? stateChangeWebHook,
    String Function()? startTimerWebHook,
    String Function()? stopTimerWebHook,
    String Function()? resetTimerWebHook,
    Locale Function()? locale,
  }) {
    return SettingsState(
      themeMode: themeMode != null ? themeMode() : this.themeMode,
      alwaysOnTop: alwaysOnTop != null ? alwaysOnTop() : this.alwaysOnTop,
      autoAdvance: autoAdvance != null ? autoAdvance() : this.autoAdvance,
      enableWebHooks:
          enableWebHooks != null ? enableWebHooks() : this.enableWebHooks,
      enableSound: enableSound != null ? enableSound() : this.enableSound,
      workMinutes: workMinutes != null ? workMinutes() : this.workMinutes,
      shortBreakMinutes: shortBreakMinutes != null
          ? shortBreakMinutes()
          : this.shortBreakMinutes,
      longBreakMinutes:
          longBreakMinutes != null ? longBreakMinutes() : this.longBreakMinutes,
      lapCount: lapCount != null ? lapCount() : this.lapCount,
      workStartWebHook:
          workStartWebHook != null ? workStartWebHook() : this.workStartWebHook,
      workEndWebHook:
          workEndWebHook != null ? workEndWebHook() : this.workEndWebHook,
      shortBreakStartWebHook: shortBreakStartWebHook != null
          ? shortBreakStartWebHook()
          : this.shortBreakStartWebHook,
      shortBreakEndWebHook: shortBreakEndWebHook != null
          ? shortBreakEndWebHook()
          : this.shortBreakEndWebHook,
      longBreakStartWebHook: longBreakStartWebHook != null
          ? longBreakStartWebHook()
          : this.longBreakStartWebHook,
      longBreakEndWebHook: longBreakEndWebHook != null
          ? longBreakEndWebHook()
          : this.longBreakEndWebHook,
      stateChangeWebHook: stateChangeWebHook != null
          ? stateChangeWebHook()
          : this.stateChangeWebHook,
      startTimerWebHook: startTimerWebHook != null
          ? startTimerWebHook()
          : this.startTimerWebHook,
      stopTimerWebHook:
          stopTimerWebHook != null ? stopTimerWebHook() : this.stopTimerWebHook,
      resetTimerWebHook: resetTimerWebHook != null
          ? resetTimerWebHook()
          : this.resetTimerWebHook,
      locale: locale != null ? locale() : this.locale,
    );
  }

  @override
  List<Object> get props => [
        themeMode,
        alwaysOnTop,
        autoAdvance,
        enableWebHooks,
        enableSound,
        workMinutes,
        shortBreakMinutes,
        longBreakMinutes,
        lapCount,
        workStartWebHook,
        workEndWebHook,
        shortBreakStartWebHook,
        shortBreakEndWebHook,
        longBreakStartWebHook,
        longBreakEndWebHook,
        stateChangeWebHook,
        startTimerWebHook,
        stopTimerWebHook,
        resetTimerWebHook,
        locale,
      ];
}

final class SettingsInitial extends SettingsState {}
