import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kThemeMode = 'theme.mode';

class ThemeStorage {
  ThemeStorage(this._prefs);

  final SharedPreferences _prefs;

  ThemeMode readThemeMode() {
    final modeName = _prefs.getString(_kThemeMode);
    return ThemeMode.values.firstWhere(
      (e) => e.name == modeName,
      orElse: () => ThemeMode.system
    );
  }
  Future<void> writeThemeMode(ThemeMode mode) async {
    await _prefs.setString(_kThemeMode, mode.name);
  }
}