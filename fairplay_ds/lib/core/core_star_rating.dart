import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/icon_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/typography_theme.dart';
import 'package:flutter/material.dart';

class CoreStarRating extends StatelessWidget {
  const CoreStarRating({
    required this.rating,
    this.reviewsCount,
    this.color = CoreColorType.alert,
    this.colorReviews = CoreColorType.neutral400,
    this.maxStars = 5,
    this.sizeReviews = CoreTextType.caption,
  });

  final int? reviewsCount;
  final double rating;
  final CoreColorType color;
  final CoreColorType colorReviews;
  final CoreTextType sizeReviews;
  final int maxStars;

  CoreIcon _generateStars(int index) {
    if (index >= rating) {
      return CoreIcon(
        color: color,
        icon: Icons.star_border_rounded,
        iconSize: CoreIconSizeType.tiny,
      );
    } else if (index > rating - 1) {
      return CoreIcon(
        color: color,
        icon: Icons.star_half_rounded,
        iconSize: CoreIconSizeType.tiny,
      );
    }

    return CoreIcon(
      color: color,
      icon: Icons.star_rounded,
      iconSize: CoreIconSizeType.tiny,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<CoreIcon> _parseStars = List<CoreIcon>.generate(
      maxStars,
      _generateStars,
    );

    return CoreContainer(
      visible: rating > 0,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            children: _parseStars,
          ),
          CoreContainer(
            visible: reviewsCount != null,
            margin: const CoreSpacing(
              left: CoreSpacingType.tiny,
            ),
            child: CoreTypography(
              '($reviewsCount)',
              color: colorReviews,
              type: sizeReviews,
            ),
          ),
        ],
      ),
    );
  }
}
