import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for SharedPreferences
class Prefs {
  /// Factory constructor
  factory Prefs() {
    return _singleton;
  }

  Prefs._internal();

  /// Singleton instance
  static final Prefs _singleton = Prefs._internal();

  /// SharedPreferences instance
  late SharedPreferences sharedPreferences;

  /// Get the SharedPreferences instance
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Get a value from SharedPreferences
  static dynamic get(String key) {
    return Prefs().sharedPreferences.get(key);
  }

  /// Set a value in SharedPreferences
  static Future<bool> set(String key, dynamic value) {
    switch (value.runtimeType) {
      case bool:
        return Prefs().sharedPreferences.setBool(key, value as bool);
      case int:
        return Prefs().sharedPreferences.setInt(key, value as int);
      case double:
        return Prefs().sharedPreferences.setDouble(key, value as double);
      case String:
        return Prefs().sharedPreferences.setString(key, value as String);
      default:
        if (value is List<String>) {
          return Prefs().sharedPreferences.setStringList(key, value);
        }

        throw Exception('Invalid value type');
    }
  }

  /// Remove a value from SharedPreferences
  static Future<bool> remove(String key) {
    return Prefs().sharedPreferences.remove(key);
  }

  /// Clear all values from SharedPreferences
  static Future<bool> clear() {
    return Prefs().sharedPreferences.clear();
  }

  /// Check if a key exists in SharedPreferences
  static bool containsKey(String key) {
    return Prefs().sharedPreferences.containsKey(key);
  }

  /// Get all keys in SharedPreferences
  static Set<String> getKeys() {
    return Prefs().sharedPreferences.getKeys();
  }

  //* Custom methods

  //* Var names

  static const String _themeModeVarName = 'pomo_theme_mode';
  static const String _languageVarName = 'pomo_language';
  static const String _longBreakMinutesVarName = 'pomo_long_break_minutes';
  static const String _shortBreakMinutesVarName = 'pomo_short_break_minutes';
  static const String _workMinutesVarName = 'pomo_work_minutes';
  static const String _workStartWebHookVarName = 'pomo_work_start_webhook';
  static const String _workEndWebHookVarName = 'pomo_work_end_webhook';
  static const String _shortBreakStartWebHookVarName =
      'pomo_short_break_start_webhook';
  static const String _shortBreakEndWebHookVarName =
      'pomo_short_break_end_webhook';
  static const String _longBreakStartWebHookVarName =
      'pomo_long_break_start_webhook';
  static const String _longBreakEndWebHookVarName =
      'pomo_long_break_end_webhook';
  static const String _stateChangeWebHookVarName = 'pomo_state_change_webhook';
  static const String _startTimerWebHookVarName = 'pomo_start_timer_webhook';
  static const String _stopTimerWebHookVarName = 'pomo_stop_timer_webhook';
  static const String _resetTimerWebHookVarName = 'pomo_reset_timer_webhook';

  //* Getters

  //* Getters
  static ThemeMode get themeMode {
    return ThemeMode.values
            .where(
              (e) =>
                  e.name ==
                  (Prefs().sharedPreferences.getString(_themeModeVarName) ??
                      'system'),
            )
            .firstOrNull ??
        ThemeMode.system;
  }

  static Locale get language {
    return Locale.fromSubtags(
      languageCode:
          Prefs().sharedPreferences.getString(_languageVarName) ?? 'en',
    );
  }

  static int get longBreakMinutes {
    return Prefs().sharedPreferences.getInt(_longBreakMinutesVarName) ?? 0;
  }

  static int get shortBreakMinutes {
    return Prefs().sharedPreferences.getInt(_shortBreakMinutesVarName) ?? 0;
  }

  static int get workMinutes {
    return Prefs().sharedPreferences.getInt(_workMinutesVarName) ?? 0;
  }

  static String get workStartWebHook {
    return Prefs().sharedPreferences.getString(_workStartWebHookVarName) ?? '';
  }

  static String get workEndWebHook {
    return Prefs().sharedPreferences.getString(_workEndWebHookVarName) ?? '';
  }

  static String get shortBreakStartWebHook {
    return Prefs()
            .sharedPreferences
            .getString(_shortBreakStartWebHookVarName) ??
        '';
  }

  static String get shortBreakEndWebHook {
    return Prefs().sharedPreferences.getString(_shortBreakEndWebHookVarName) ??
        '';
  }

  static String get longBreakStartWebHook {
    return Prefs().sharedPreferences.getString(_longBreakStartWebHookVarName) ??
        '';
  }

  static String get longBreakEndWebHook {
    return Prefs().sharedPreferences.getString(_longBreakEndWebHookVarName) ??
        '';
  }

  static String get stateChangeWebHook {
    return Prefs().sharedPreferences.getString(_stateChangeWebHookVarName) ??
        '';
  }

  static String get startTimerWebHook {
    return Prefs().sharedPreferences.getString(_startTimerWebHookVarName) ?? '';
  }

  static String get stopTimerWebHook {
    return Prefs().sharedPreferences.getString(_stopTimerWebHookVarName) ?? '';
  }

  static String get resetTimerWebHook {
    return Prefs().sharedPreferences.getString(_resetTimerWebHookVarName) ?? '';
  }

  //* Setters

  static Future<bool> setThemeMode(ThemeMode value) {
    return Prefs().sharedPreferences.setString(_themeModeVarName, value.name);
  }

  static Future<bool> setLanguage(Locale value) {
    return Prefs()
        .sharedPreferences
        .setString(_languageVarName, value.languageCode);
  }

  static Future<bool> setLongBreakMinutes(int value) {
    return Prefs().sharedPreferences.setInt(_longBreakMinutesVarName, value);
  }

  static Future<bool> setShortBreakMinutes(int value) {
    return Prefs().sharedPreferences.setInt(_shortBreakMinutesVarName, value);
  }

  static Future<bool> setWorkMinutes(int value) {
    return Prefs().sharedPreferences.setInt(_workMinutesVarName, value);
  }

  static Future<bool> setWorkStartWebHook(String value) {
    return Prefs().sharedPreferences.setString(_workStartWebHookVarName, value);
  }

  static Future<bool> setWorkEndWebHook(String value) {
    return Prefs().sharedPreferences.setString(_workEndWebHookVarName, value);
  }

  static Future<bool> setShortBreakStartWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_shortBreakStartWebHookVarName, value);
  }

  static Future<bool> setShortBreakEndWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_shortBreakEndWebHookVarName, value);
  }

  static Future<bool> setLongBreakStartWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_longBreakStartWebHookVarName, value);
  }

  static Future<bool> setLongBreakEndWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_longBreakEndWebHookVarName, value);
  }

  static Future<bool> setStateChangeWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_stateChangeWebHookVarName, value);
  }

  static Future<bool> setStartTimerWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_startTimerWebHookVarName, value);
  }

  static Future<bool> setStopTimerWebHook(String value) {
    return Prefs().sharedPreferences.setString(_stopTimerWebHookVarName, value);
  }

  static Future<bool> setResetTimerWebHook(String value) {
    return Prefs()
        .sharedPreferences
        .setString(_resetTimerWebHookVarName, value);
  }
}
