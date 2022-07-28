import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoreShimmer extends StatelessWidget {
  const CoreShimmer({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context)
          .extension<CoreColorTheme>()!
          .values[CoreColorType.neutral300]!,
      highlightColor: Theme.of(context)
          .extension<CoreColorTheme>()!
          .values[CoreColorType.neutral200]!,
      child: this.child,
    );
  }
}
