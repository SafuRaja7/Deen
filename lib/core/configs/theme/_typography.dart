part of '../configs.dart';

abstract class AppText {
  static late TextStyle h1;
  static late TextStyle h2;
  static late TextStyle h3;

  static late TextStyle b1;
  static late TextStyle b2;
  static late TextStyle b3;

  static late TextStyle s1;
  static late TextStyle s2;

  static String fontFamily = "Poppins";

  static void init() {
    final base = TextStyle(fontFamily: fontFamily);

    h1 = base.copyWith(fontSize: 32).ratioHeight();
    h2 = base.copyWith(fontSize: 24).ratioHeight();
    h3 = base.copyWith(fontSize: 20).ratioHeight();

    //
    b1 = base.copyWith(fontSize: 18).ratioHeight();
    b2 = base.copyWith(fontSize: 16).ratioHeight();
    b3 = base.copyWith(fontSize: 14).ratioHeight();

    //
    s1 = base.copyWith(fontSize: 11).ratioHeight();
    s2 = base.copyWith(fontSize: 10).ratioHeight();
  }
}
