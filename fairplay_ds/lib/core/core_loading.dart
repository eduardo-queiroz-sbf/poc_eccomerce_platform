import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_progress_indicator.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

class CoreLoading extends StatelessWidget {
  const CoreLoading({
    this.title = '',
    this.height = 600,
  });

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CoreContainer(
      width: double.infinity,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoreContainer(
              padding: CoreSpacing(
                bottom: CoreSpacingType.large,
              ),
              child: CoreProgressIndicator.large(),
            ),
            CoreTypography.bodyText2Normal(title),
          ],
        ),
      ),
    );
  }
}
