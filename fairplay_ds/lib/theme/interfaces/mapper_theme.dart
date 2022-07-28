import 'package:flutter/material.dart';

mixin MapperThemeBehavior<T extends ThemeExtension<T>> {
  ThemeExtension<T> copyWith() {
    throw UnimplementedError();
  }

  ThemeExtension<T> lerp(ThemeExtension<T>? other, double t) {
    return other!;
  }
}
