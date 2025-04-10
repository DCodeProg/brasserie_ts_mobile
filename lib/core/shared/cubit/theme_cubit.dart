import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void selectThemeMode(ThemeMode themeMode) {
    emit(themeMode);
  }

  void nextThemeMode() {
    switch (state) {
      case ThemeMode.dark:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.system);
      case ThemeMode.system:
        emit(ThemeMode.dark);
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state.index};
  }
}
