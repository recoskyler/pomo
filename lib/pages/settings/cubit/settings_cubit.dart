import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pomo/helpers/hook_helper.dart';
import 'package:pomo/singletons/prefs.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void loadSettings() {
    emit(
      SettingsState(
        alwaysOnTop: Prefs.alwaysOnTop,
        themeMode: Prefs.themeMode,
        autoAdvance: Prefs.autoAdvance,
        workMinutes: Prefs.workMinutes,
        shortBreakMinutes: Prefs.shortBreakMinutes,
        longBreakMinutes: Prefs.longBreakMinutes,
        lapCount: Prefs.lapCount,
        workStartWebHook: Prefs.workStartWebHook,
        workEndWebHook: Prefs.workEndWebHook,
        shortBreakStartWebHook: Prefs.shortBreakStartWebHook,
        shortBreakEndWebHook: Prefs.shortBreakEndWebHook,
        longBreakStartWebHook: Prefs.longBreakStartWebHook,
        longBreakEndWebHook: Prefs.longBreakEndWebHook,
        startTimerWebHook: Prefs.startTimerWebHook,
        stopTimerWebHook: Prefs.stopTimerWebHook,
        resetTimerWebHook: Prefs.resetTimerWebHook,
        enableWebHooks: Prefs.enableWebhooks,
        enableSound: Prefs.enableSound,
        triggerMethod: Prefs.triggerMethod,
        timerFont: Prefs.timerFont,
        timerCustomFont: Prefs.timerCustomFont,
        colorSeed: Prefs.colorSeed,
        customWorkStartSound: Prefs.customWorkStartSound,
        customWorkEndSound: Prefs.customWorkEndSound,
        customShortBreakStartSound: Prefs.customShortBreakStartSound,
        customShortBreakEndSound: Prefs.customShortBreakEndSound,
        customLongBreakStartSound: Prefs.customLongBreakStartSound,
        customLongBreakEndSound: Prefs.customLongBreakEndSound,
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void setAlwaysOnTop(bool value) {
    Prefs.alwaysOnTop = value;
    emit(state.copyWith(alwaysOnTop: () => value));
  }

  void setThemeMode(ThemeMode value) {
    Prefs.themeMode = value;
    emit(state.copyWith(themeMode: () => value));
  }

  // ignore: avoid_positional_boolean_parameters
  void setAutoAdvance(bool value) {
    Prefs.autoAdvance = value;
    emit(state.copyWith(autoAdvance: () => value));
  }

  void setWorkMinutes(int value) {
    Prefs.workMinutes = value;
    emit(state.copyWith(workMinutes: () => value));
  }

  void setShortBreakMinutes(int value) {
    Prefs.shortBreakMinutes = value;
    emit(state.copyWith(shortBreakMinutes: () => value));
  }

  void setLongBreakMinutes(int value) {
    Prefs.longBreakMinutes = value;
    emit(state.copyWith(longBreakMinutes: () => value));
  }

  void setLapCount(int value) {
    Prefs.lapCount = value;
    emit(state.copyWith(lapCount: () => value));
  }

  void setWorkStartWebHook(String value) {
    Prefs.workStartWebHook = value;
    emit(state.copyWith(workStartWebHook: () => value));
  }

  void setWorkEndWebHook(String value) {
    Prefs.workEndWebHook = value;
    emit(state.copyWith(workEndWebHook: () => value));
  }

  void setShortBreakStartWebHook(String value) {
    Prefs.shortBreakStartWebHook = value;
    emit(state.copyWith(shortBreakStartWebHook: () => value));
  }

  void setShortBreakEndWebHook(String value) {
    Prefs.shortBreakEndWebHook = value;
    emit(state.copyWith(shortBreakEndWebHook: () => value));
  }

  void setLongBreakStartWebHook(String value) {
    Prefs.longBreakStartWebHook = value;
    emit(state.copyWith(longBreakStartWebHook: () => value));
  }

  void setLongBreakEndWebHook(String value) {
    Prefs.longBreakEndWebHook = value;
    emit(state.copyWith(longBreakEndWebHook: () => value));
  }

  void setStartTimerWebHook(String value) {
    Prefs.startTimerWebHook = value;
    emit(state.copyWith(startTimerWebHook: () => value));
  }

  void setStopTimerWebHook(String value) {
    Prefs.stopTimerWebHook = value;
    emit(state.copyWith(stopTimerWebHook: () => value));
  }

  void setResetTimerWebHook(String value) {
    Prefs.resetTimerWebHook = value;
    emit(state.copyWith(resetTimerWebHook: () => value));
  }

  // ignore: avoid_positional_boolean_parameters
  void setEnableWebHooks(bool value) {
    Prefs.enableWebhooks = value;
    emit(state.copyWith(enableWebHooks: () => value));
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleSound() {
    Prefs.enableSound = !state.enableSound;
    emit(state.copyWith(enableSound: () => !state.enableSound));
  }

  void setTriggerMethod(TriggerMethod value) {
    Prefs.triggerMethod = value;
    emit(state.copyWith(triggerMethod: () => value));
  }

  void setTimerFont(TimerFont value) {
    Prefs.timerFont = value;
    emit(state.copyWith(timerFont: () => value));
  }

  void setTimerCustomFont(String value) {
    Prefs.timerCustomFont = value;
    emit(state.copyWith(timerCustomFont: () => value));
  }

  void setColorSeed(Color? value) {
    Prefs.colorSeed = value;
    emit(state.copyWith(colorSeed: () => value));
  }

  void setCustomWorkStartSound(String value) {
    Prefs.customWorkStartSound = value;
    emit(state.copyWith(customWorkStartSound: () => value));
  }

  void setCustomWorkEndSound(String value) {
    Prefs.customWorkEndSound = value;
    emit(state.copyWith(customWorkEndSound: () => value));
  }

  void setCustomShortBreakStartSound(String value) {
    Prefs.customShortBreakStartSound = value;
    emit(state.copyWith(customShortBreakStartSound: () => value));
  }

  void setCustomShortBreakEndSound(String value) {
    Prefs.customShortBreakEndSound = value;
    emit(state.copyWith(customShortBreakEndSound: () => value));
  }

  void setCustomLongBreakStartSound(String value) {
    Prefs.customLongBreakStartSound = value;
    emit(state.copyWith(customLongBreakStartSound: () => value));
  }

  void setCustomLongBreakEndSound(String value) {
    Prefs.customLongBreakEndSound = value;
    emit(state.copyWith(customLongBreakEndSound: () => value));
  }
}
