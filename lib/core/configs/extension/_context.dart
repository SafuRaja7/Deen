part of '../configs.dart';

extension SuperContext on BuildContext {
  void dismissKeyboard() {
    if (FocusScope.of(this).hasFocus) {
      FocusScope.of(this).unfocus();
    }
  }

  String? currentPath() {
    return ModalRoute.of(this)?.settings.name;
  }

  double topSafe() {
    final view = MediaQueryData.fromView(View.of(this));
    final height = view.padding.top;
    return height;
  }

  double bottomSafe() {
    final view = MediaQueryData.fromView(View.of(this));
    final height = view.padding.bottom;
    return height;
  }
}
