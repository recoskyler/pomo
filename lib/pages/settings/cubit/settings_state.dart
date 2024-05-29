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
    this.startTimerWebHook = '',
    this.stopTimerWebHook = '',
    this.resetTimerWebHook = '',
    this.tickWebHook = '',
    this.locale = const Locale('en'),
    this.enableWebHooks = false,
    this.enableSound = true,
    this.triggerMethod = TriggerMethod.post,
    this.timerFont = TimerFont.boldMono,
    this.timerCustomFont = '',
    this.colorSeed,
    this.customWorkStartSound = '',
    this.customWorkEndSound = '',
    this.customShortBreakStartSound = '',
    this.customShortBreakEndSound = '',
    this.customLongBreakStartSound = '',
    this.customLongBreakEndSound = '',
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
  final String startTimerWebHook;
  final String stopTimerWebHook;
  final String resetTimerWebHook;
  final String tickWebHook;

  final String timerCustomFont;

  final String customWorkStartSound;
  final String customWorkEndSound;
  final String customShortBreakStartSound;
  final String customShortBreakEndSound;
  final String customLongBreakStartSound;
  final String customLongBreakEndSound;

  final Locale locale;

  final TriggerMethod triggerMethod;
  final TimerFont timerFont;

  final Color? colorSeed;

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
    String Function()? startTimerWebHook,
    String Function()? stopTimerWebHook,
    String Function()? resetTimerWebHook,
    String Function()? tickWebHook,
    Locale Function()? locale,
    TriggerMethod Function()? triggerMethod,
    TimerFont Function()? timerFont,
    String Function()? timerCustomFont,
    Color? Function()? colorSeed,
    String Function()? customWorkStartSound,
    String Function()? customWorkEndSound,
    String Function()? customShortBreakStartSound,
    String Function()? customShortBreakEndSound,
    String Function()? customLongBreakStartSound,
    String Function()? customLongBreakEndSound,
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
      startTimerWebHook: startTimerWebHook != null
          ? startTimerWebHook()
          : this.startTimerWebHook,
      stopTimerWebHook:
          stopTimerWebHook != null ? stopTimerWebHook() : this.stopTimerWebHook,
      resetTimerWebHook: resetTimerWebHook != null
          ? resetTimerWebHook()
          : this.resetTimerWebHook,
      tickWebHook: tickWebHook != null ? tickWebHook() : this.tickWebHook,
      locale: locale != null ? locale() : this.locale,
      triggerMethod:
          triggerMethod != null ? triggerMethod() : this.triggerMethod,
      timerFont: timerFont != null ? timerFont() : this.timerFont,
      timerCustomFont:
          timerCustomFont != null ? timerCustomFont() : this.timerCustomFont,
      colorSeed: colorSeed != null ? colorSeed() : this.colorSeed,
      customWorkStartSound: customWorkStartSound != null
          ? customWorkStartSound()
          : this.customWorkStartSound,
      customWorkEndSound: customWorkEndSound != null
          ? customWorkEndSound()
          : this.customWorkEndSound,
      customShortBreakStartSound: customShortBreakStartSound != null
          ? customShortBreakStartSound()
          : this.customShortBreakStartSound,
      customShortBreakEndSound: customShortBreakEndSound != null
          ? customShortBreakEndSound()
          : this.customShortBreakEndSound,
      customLongBreakStartSound: customLongBreakStartSound != null
          ? customLongBreakStartSound()
          : this.customLongBreakStartSound,
      customLongBreakEndSound: customLongBreakEndSound != null
          ? customLongBreakEndSound()
          : this.customLongBreakEndSound,
    );
  }

  @override
  List<Object?> get props => [
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
        startTimerWebHook,
        stopTimerWebHook,
        resetTimerWebHook,
        tickWebHook,
        locale,
        triggerMethod,
        timerFont,
        timerCustomFont,
        colorSeed,
        customWorkStartSound,
        customWorkEndSound,
        customShortBreakStartSound,
        customShortBreakEndSound,
        customLongBreakStartSound,
        customLongBreakEndSound,
      ];
}

final class SettingsInitial extends SettingsState {}
