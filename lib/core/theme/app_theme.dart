import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff646116),
      surfaceTint: Color(0xff646116),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffebe68d),
      onPrimaryContainer: Color(0xff4b4900),
      secondary: Color(0xff626042),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe8e4be),
      onSecondaryContainer: Color(0xff49482c),
      tertiary: Color(0xff3e6655),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc0ecd6),
      onTertiaryContainer: Color(0xff264e3e),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef9ec),
      onSurface: Color(0xff1d1c14),
      onSurfaceVariant: Color(0xff49473a),
      outline: Color(0xff7a7768),
      outlineVariant: Color(0xffcac7b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xffceca74),
      primaryFixed: Color(0xffebe68d),
      onPrimaryFixed: Color(0xff1e1c00),
      primaryFixedDim: Color(0xffceca74),
      onPrimaryFixedVariant: Color(0xff4b4900),
      secondaryFixed: Color(0xffe8e4be),
      onSecondaryFixed: Color(0xff1d1c05),
      secondaryFixedDim: Color(0xffcbc8a4),
      onSecondaryFixedVariant: Color(0xff49482c),
      tertiaryFixed: Color(0xffc0ecd6),
      onTertiaryFixed: Color(0xff002115),
      tertiaryFixedDim: Color(0xffa5d0bb),
      onTertiaryFixedVariant: Color(0xff264e3e),
      surfaceDim: Color(0xffdedacd),
      surfaceBright: Color(0xfffef9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f4e6),
      surfaceContainer: Color(0xfff2eee0),
      surfaceContainerHigh: Color(0xffece8db),
      surfaceContainerHighest: Color(0xffe6e2d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3a3800),
      surfaceTint: Color(0xff646116),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff737024),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff39371d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff706e50),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff143d2e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4d7563),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef9ec),
      onSurface: Color(0xff12110a),
      onSurfaceVariant: Color(0xff38372a),
      outline: Color(0xff545345),
      outlineVariant: Color(0xff6f6d5f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xffceca74),
      primaryFixed: Color(0xff737024),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5a570b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff706e50),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff585639),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4d7563),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff355c4c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcac6ba),
      surfaceBright: Color(0xfffef9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f4e6),
      surfaceContainer: Color(0xffece8db),
      surfaceContainerHigh: Color(0xffe1ddd0),
      surfaceContainerHighest: Color(0xffd5d2c5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2f2d00),
      surfaceTint: Color(0xff646116),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4e4b00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e2d14),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4c4a2e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff073324),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff295140),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef9ec),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2e2d21),
      outlineVariant: Color(0xff4b4a3c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xffceca74),
      primaryFixed: Color(0xff4e4b00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff363400),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4c4a2e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff35341a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff295140),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff103a2b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbcb9ac),
      surfaceBright: Color(0xfffef9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f1e3),
      surfaceContainer: Color(0xffe6e2d5),
      surfaceContainerHigh: Color(0xffd8d4c7),
      surfaceContainerHighest: Color(0xffcac6ba),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffceca74),
      surfaceTint: Color(0xffceca74),
      onPrimary: Color(0xff343200),
      primaryContainer: Color(0xff4b4900),
      onPrimaryContainer: Color(0xffebe68d),
      secondary: Color(0xffcbc8a4),
      onSecondary: Color(0xff333118),
      secondaryContainer: Color(0xff49482c),
      onSecondaryContainer: Color(0xffe8e4be),
      tertiary: Color(0xffa5d0bb),
      onTertiary: Color(0xff0d3728),
      tertiaryContainer: Color(0xff264e3e),
      onTertiaryContainer: Color(0xffc0ecd6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff14140c),
      onSurface: Color(0xffe6e2d5),
      onSurfaceVariant: Color(0xffcac7b5),
      outline: Color(0xff949181),
      outlineVariant: Color(0xff49473a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff646116),
      primaryFixed: Color(0xffebe68d),
      onPrimaryFixed: Color(0xff1e1c00),
      primaryFixedDim: Color(0xffceca74),
      onPrimaryFixedVariant: Color(0xff4b4900),
      secondaryFixed: Color(0xffe8e4be),
      onSecondaryFixed: Color(0xff1d1c05),
      secondaryFixedDim: Color(0xffcbc8a4),
      onSecondaryFixedVariant: Color(0xff49482c),
      tertiaryFixed: Color(0xffc0ecd6),
      onTertiaryFixed: Color(0xff002115),
      tertiaryFixedDim: Color(0xffa5d0bb),
      onTertiaryFixedVariant: Color(0xff264e3e),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff3b3930),
      surfaceContainerLowest: Color(0xff0f0e07),
      surfaceContainerLow: Color(0xff1d1c14),
      surfaceContainer: Color(0xff212018),
      surfaceContainerHigh: Color(0xff2b2a22),
      surfaceContainerHighest: Color(0xff36352c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe5e088),
      surfaceTint: Color(0xffceca74),
      onPrimary: Color(0xff282700),
      primaryContainer: Color(0xff979445),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe2deb9),
      onSecondary: Color(0xff28270e),
      secondaryContainer: Color(0xff959271),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbae6d0),
      onTertiary: Color(0xff002c1e),
      tertiaryContainer: Color(0xff709a86),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff14140c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0ddcb),
      outline: Color(0xffb5b2a1),
      outlineVariant: Color(0xff939181),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff4d4a00),
      primaryFixed: Color(0xffebe68d),
      onPrimaryFixed: Color(0xff131200),
      primaryFixedDim: Color(0xffceca74),
      onPrimaryFixedVariant: Color(0xff3a3800),
      secondaryFixed: Color(0xffe8e4be),
      onSecondaryFixed: Color(0xff131201),
      secondaryFixedDim: Color(0xffcbc8a4),
      onSecondaryFixedVariant: Color(0xff39371d),
      tertiaryFixed: Color(0xffc0ecd6),
      onTertiaryFixed: Color(0xff00150d),
      tertiaryFixedDim: Color(0xffa5d0bb),
      onTertiaryFixedVariant: Color(0xff143d2e),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff46453b),
      surfaceContainerLowest: Color(0xff080803),
      surfaceContainerLow: Color(0xff1f1e16),
      surfaceContainer: Color(0xff292820),
      surfaceContainerHigh: Color(0xff34332a),
      surfaceContainerHighest: Color(0xff3f3e34),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9f499),
      surfaceTint: Color(0xffceca74),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcac671),
      onPrimaryContainer: Color(0xff0d0c00),
      secondary: Color(0xfff6f1cb),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc7c4a0),
      onSecondaryContainer: Color(0xff0d0c00),
      tertiary: Color(0xffcefae4),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa1ccb7),
      onTertiaryContainer: Color(0xff000e08),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff14140c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4f0de),
      outlineVariant: Color(0xffc6c3b2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff4d4a00),
      primaryFixed: Color(0xffebe68d),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffceca74),
      onPrimaryFixedVariant: Color(0xff131200),
      secondaryFixed: Color(0xffe8e4be),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcbc8a4),
      onSecondaryFixedVariant: Color(0xff131201),
      tertiaryFixed: Color(0xffc0ecd6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa5d0bb),
      onTertiaryFixedVariant: Color(0xff00150d),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff525046),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff212018),
      surfaceContainer: Color(0xff323128),
      surfaceContainerHigh: Color(0xff3d3c32),
      surfaceContainerHighest: Color(0xff48473d),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
