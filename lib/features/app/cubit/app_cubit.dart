import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  static const String _themeKey = 'theme_mode';

  Future<void> loadTheme() async {
    try {
      final box = await Hive.openBox('settings');
      final themeIndex = box.get(_themeKey, defaultValue: 0);
      final themeMode = ThemeMode.values[themeIndex];
      emit(state.copyWith(themeMode: themeMode));
    } catch (e) {
      // Handle error silently, keep default theme
    }
  }

  Future<void> toggleTheme() async {
    try {
      final newThemeMode = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

      final box = await Hive.openBox('settings');
      await box.put(_themeKey, newThemeMode.index);

      emit(state.copyWith(themeMode: newThemeMode));
    } catch (e) {
      // Handle error
    }
  }
}
