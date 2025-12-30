part of '../configs.dart';

extension SuperTextStyles on TextStyle {
  TextStyle ratioHeight() {
    final ratio = (fontSize! / 0.8) / fontSize!;
    return copyWith(height: ratio);
  }

  TextStyle removeHeight() {
    return merge(const TextStyle(height: 0));
  }

  TextStyle operator +(Object other) {
    if (other is Color) {
      return copyWith(color: other);
    } else if (other is FontWeight) {
      return copyWith(fontWeight: other);
    } else if (other is double) {
      return copyWith(fontSize: other);
    }
    return this;
  }
}
