part of 'configs.dart';

abstract class AppProps {
  static const quick = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 300);
  static const normal = Duration(milliseconds: 500);

  static final radiusTop = BorderRadius.vertical(top: Radius.circular(6.un()));

  static final radiusTopDec = BoxDecoration(
    color: AppTheme.c.background,
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.un())),
  );

  static final softShadow = [
    BoxShadow(color: AppTheme.c.textDark, blurRadius: 10),
  ];

  static final card = BoxDecoration(
    color: AppTheme.c.background,
    borderRadius: 15.radius(),
    boxShadow: [
      BoxShadow(
        color: AppTheme.c.textSub.withValues(alpha: .35),
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  );

  static final plainGrey = BoxDecoration(
    color: AppTheme.c.textSub,
    borderRadius: 15.radius(),
  );
}
