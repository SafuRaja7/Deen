import 'package:flutter/material.dart';
import 'responsive_config.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Helper methods for quick checks
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < ResponsiveConfig.mobileLimit;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= ResponsiveConfig.mobileLimit &&
      MediaQuery.of(context).size.width < ResponsiveConfig.tabletLimit;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= ResponsiveConfig.tabletLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveConfig.tabletLimit) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= ResponsiveConfig.mobileLimit) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Extension for easy access to responsive dimensions
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns value based on screen size
  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (screenWidth >= ResponsiveConfig.tabletLimit) {
      return desktop ?? tablet ?? mobile;
    } else if (screenWidth >= ResponsiveConfig.mobileLimit) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}
