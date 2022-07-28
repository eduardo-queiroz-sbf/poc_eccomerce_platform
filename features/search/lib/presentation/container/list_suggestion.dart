import 'package:search/domain/entities/search_autocomplete.dart';
import './item_suggestion.dart';
import 'package:foundation/infra/util/constrains.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_staggered.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';

class ListSuggestionComponent extends StatelessWidget {
  const ListSuggestionComponent({
    Key? key,
    required this.suggestion,
    required this.query,
  }) : super(key: key);

  final String query;
  final SearchAutoCompleteEntity suggestion;

  @override
  Widget build(BuildContext context) {
    return CoreContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CoreContainer(
            padding: const CoreSpacing(bottom: CoreSpacingType.medium),
            child: CoreTypography.bodyText1(
              query.isEmpty ? 'Mais Procurados' : 'Resultados encontrados',
            ),
          ),
          CoreStaggered(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: suggestion.queries.length,
              itemBuilder: (BuildContext context, int index) {
                return CoreStaggeredList(
                  index: index,
                  child: ItemSuggestionComponent(
                    query: query,
                    suggestion: suggestion.queries[index].query,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
