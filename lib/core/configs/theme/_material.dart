part of '../configs.dart';

final materialLightTheme = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  useMaterial3: false,
  primaryColor: _lightTheme.primary,
  primaryColorDark: _lightTheme.primary,
  colorScheme: ColorScheme.light(
    primary: _lightTheme.primary,
    secondary: _lightTheme.primary,
    surface: _lightTheme.background,
    onPrimary: _lightTheme.primary,
  ),
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: _lightTheme.background,
  textTheme: (const TextTheme()).apply(fontFamily: 'Poppins'),
);
