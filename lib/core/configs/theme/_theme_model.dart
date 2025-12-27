part of '../configs.dart';

class ThemeModel {
  final Color background;
  final Color textDark;
  final Color textSub;
  final Color primary;
  final Color tertiary;
  final Color black;
  final Color white;

  const ThemeModel({
    required this.textDark,
    required this.textSub,
    required this.background,
    required this.primary,
    required this.tertiary,
    required this.black,
    required this.white,
  });

  ThemeModel copyWith({
    Color? textDark,
    Color? textSub,
    Color? background,
    Color? primary,
    Color? tertiary,
    Color? black,
    Color? white,
  }) {
    return ThemeModel(
      textDark: textDark ?? this.textDark,
      textSub: textSub ?? this.textSub,
      background: background ?? this.background,
      tertiary: tertiary ?? this.tertiary,
      primary: primary ?? this.primary,
      black: black ?? this.black,
      white: white ?? this.white,
    );
  }
}
