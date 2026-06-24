import 'package:flutter/material.dart';
import 'package:notidialca/app/theme/theme_storage.dart';
import 'package:notidialca/core/storage/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  Future<ThemeMode> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final storage = ThemeStorage(prefs);
    return storage.readThemeMode();
  }
  Future<void> changeTheme(ThemeMode mode) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final storage = ThemeStorage(prefs);
    await storage.writeThemeMode(mode);
    state = AsyncData(mode);
  }
}