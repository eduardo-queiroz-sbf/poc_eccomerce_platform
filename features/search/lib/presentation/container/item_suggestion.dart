// import 'package:search/app/views/search/shared/navigate_result_behavior.dart';
import 'package:foundation/infra/analytics/event_tracker.dart';
import 'package:foundation/infra/util/constrains.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';
import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:uuid/uuid.dart';

class ItemSuggestionComponent extends StatelessWidget {
  ItemSuggestionComponent({
    Key? key,
    required this.suggestion,
    required this.query,
  })  : currentTag = const Uuid().v4(),
        super(key: key);

  final String suggestion;
  final String query;
  final String currentTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        EventTracker.eventScreen(EventBundle(name: "teste"));
        // goToSearchResult(context, suggestion, currentTag);
      },
      child: CoreContainer(
        padding: const CoreSpacing(vertical: CoreSpacingType.small),
        child: Row(
          children: <Widget>[
            CoreContainer(
              padding: const CoreSpacing(right: CoreSpacingType.small),
              child: CoreIcon(
                icon: query.isEmpty ? Icons.star : Icons.search,
                color: CoreColorType.neutral300,
              ),
            ),
            CoreContainer(
              width: Constrains().width(80),
              child: Hero(
                tag: currentTag,
                child: Material(
                  child: CoreTypography.bodyText2Normal(suggestion),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
