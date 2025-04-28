import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  /// Get the actual system [Brightness].
  Brightness get systemBrightness {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  /// Go to the next [ThemeMode] depending on the system brightness
  ///
  /// Order:
  /// - system light: system - dark - light
  /// - system dark: system - light - dark
  void nextThemeMode() {
    switch (systemBrightness) {
      case Brightness.dark:
        switch (state) {
          case ThemeMode.system:
            return emit(ThemeMode.light);
          case ThemeMode.light:
            return emit(ThemeMode.dark);
          case ThemeMode.dark:
            return emit(ThemeMode.system);
        }

      case Brightness.light:
        switch (state) {
          case ThemeMode.system:
            return emit(ThemeMode.dark);
          case ThemeMode.dark:
            return emit(ThemeMode.light);
          case ThemeMode.light:
            return emit(ThemeMode.system);
        }
    }
  }

  /// Set the cubit [ThemeMode] to the selected [ThemeMode].
  void selectThemeMode(ThemeMode themeMode) => emit(themeMode);

  /// Toggle the cubit [ThemeMode] between [ThemeMode.light] and [ThemeMode.dark].
  ///
  /// Set the cubit [ThemeMode] to system brightness oposite when toggling from [ThemeMode.system].
  void toggleThemeMode() {
    switch (state) {
      case ThemeMode.system:
        return emit(
          systemBrightness == Brightness.dark
              ? ThemeMode.light
              : ThemeMode.dark,
        );

      case ThemeMode.light:
        return emit(ThemeMode.dark);

      case ThemeMode.dark:
        return emit(ThemeMode.light);
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme_mode'] as int];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme_mode': state.index};
  }
}
