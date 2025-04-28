import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:brasserie_ts_mobile/core/shared/cubit/theme_cubit.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late ThemeCubit themeCubit;
  late MockStorage mockStorage;

  setUp(() {
    mockStorage = MockStorage();
    HydratedBloc.storage = mockStorage;
    when(
      () => mockStorage.write(any(), any()),
    ).thenAnswer((_) async => Future.value());
    themeCubit = ThemeCubit();
  });

  tearDown(() {
    themeCubit.close();
  });

  test('should initial state is ThemeMode.system', () {
    // assert
    expect(themeCubit.state, equals(ThemeMode.system));
  });

  test('should saves the state to storage on state change', () {
    // arrange
    themeCubit.emit(ThemeMode.dark);

    // act
    themeCubit.emit(ThemeMode.light);

    // assert
    verify(
      () => mockStorage.write('ThemeCubit', {
        'theme_mode': ThemeMode.light.index,
      }),
    ).called(1);
  });

  test(
    'should retrieve the last state from storage when the cubit is instenciated',
    () {
      // arrange
      when(
        () => mockStorage.read('ThemeCubit'),
      ).thenReturn({'theme_mode': ThemeMode.dark.index});

      // act
      themeCubit = ThemeCubit();

      // assert
      expect(themeCubit.state, equals(ThemeMode.dark));
    },
  );

  group("systemBrightness", () {
    test(
      "should return Britness.light when platformBrightness is set to light mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;

        // act
        final Brightness brightness = themeCubit.systemBrightness;

        // assert
        expect(brightness, equals(Brightness.light));
      },
    );

    test(
      "should return Britness.dark when platformBrightness is set to dark mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.dark;

        // act
        final Brightness brightness = themeCubit.systemBrightness;

        // assert
        expect(brightness, equals(Brightness.dark));
      },
    );
  });

  group("nextThemeMode", () {
    test(
      "should emits ThemeMode.dark when previous state is ThemeMode.system if system is in light mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;

        themeCubit.emit(ThemeMode.system);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.dark));
      },
    );

    test(
      "should emits ThemeMode.light when previous state is ThemeMode.dark if system is in light mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;

        themeCubit.emit(ThemeMode.dark);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.light));
      },
    );

    test(
      "should emits ThemeMode.system when previous state is ThemeMode.light if system is in light mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;

        themeCubit.emit(ThemeMode.light);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.system));
      },
    );

    test(
      "should emits ThemeMode.light when previous state is ThemeMode.system if system is in dark mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.dark;

        themeCubit.emit(ThemeMode.system);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.light));
      },
    );

    test(
      "should emits ThemeMode.dark when previous state is ThemeMode.light if system is in dark mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.dark;

        themeCubit.emit(ThemeMode.light);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.dark));
      },
    );

    test(
      "should emits ThemeMode.system when previous state is ThemeMode.dark if system is in dark mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.dark;

        themeCubit.emit(ThemeMode.dark);

        // act
        themeCubit.nextThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.system));
      },
    );
  });

  group("selectThemeMode", () {
    test("should emit ThemeMode.light when selecting ThemeMode.light", () {
      // arrange
      themeCubit.emit(ThemeMode.system);

      // act
      themeCubit.selectThemeMode(ThemeMode.light);

      // assert
      expect(themeCubit.state, equals(ThemeMode.light));
    });

    test("should emit ThemeMode.dark when selecting ThemeMode.dark", () {
      // arrange
      themeCubit.emit(ThemeMode.system);

      // act
      themeCubit.selectThemeMode(ThemeMode.dark);

      // assert
      expect(themeCubit.state, equals(ThemeMode.dark));
    });

    test("should emit ThemeMode.system when selecting ThemeMode.system", () {
      // arrange
      themeCubit.emit(ThemeMode.light);

      // act
      themeCubit.selectThemeMode(ThemeMode.system);

      // assert
      expect(themeCubit.state, equals(ThemeMode.system));
    });
  });

  group("toogleThemeMode", () {
    test('should emits ThemeMode.light when toggling from ThemeMode.dark', () {
      // arrange
      themeCubit.emit(ThemeMode.dark);

      // act
      themeCubit.toggleThemeMode();

      // assert
      expect(themeCubit.state, equals(ThemeMode.light));
    });

    test('should emits ThemeMode.dark when toggling from ThemeMode.light', () {
      // arrange
      themeCubit.emit(ThemeMode.light);

      // act
      themeCubit.toggleThemeMode();

      // assert
      expect(themeCubit.state, equals(ThemeMode.dark));
    });

    test(
      "should emits ThemeMode.light when toggling from ThemeMode.system if system is in dark mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.dark;
        themeCubit.emit(ThemeMode.system);

        // act
        themeCubit.toggleThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.light));
      },
    );

    test(
      "should emits ThemeMode.dark when toggling from ThemeMode.system if system is in light mode",
      () {
        // arrange
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        binding.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;
        themeCubit.emit(ThemeMode.system);

        // act
        themeCubit.toggleThemeMode();

        // assert
        expect(themeCubit.state, equals(ThemeMode.dark));
      },
    );
  });
}
