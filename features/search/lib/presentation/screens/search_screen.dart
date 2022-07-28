import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_warning.dart';
import 'package:fairplay_ds/core/core_request_builder.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';
import 'package:foundation/interfaces/bloc/bloc_interface.dart';
import 'package:foundation/interfaces/builders/containers/search_header_builder.dart';
import 'package:foundation/interfaces/builders/screens/search.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:search/domain/entities/search_autocomplete.dart';
import 'package:search/presentation/container/list_suggestion.dart';
import 'package:search/presentation/shimmers/loading_suggestion.dart';
import 'package:search/presentation/usecases/search_suggestion_use_case.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen(
    @factoryParam this.routeParams,
  );

  final SearchRoute routeParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: CoreContainer(
            margin: const CoreSpacing(
              horizontal: CoreSpacingType.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchHeaderBuilder().call(),
                CoreRequestBuilder<SearchAutoCompleteEntity>(
                  load: () =>
                      (context.read<BlocInterface>() as SearchSuggestionUseCase)
                          .getSuggestion(""),
                  loading: () => LoadingSuggestionComponent(),
                  error: ({Object? error, VoidCallback? reload}) =>
                      CoreWarning.error(
                    onPress: reload!,
                  ),
                  done: (SearchAutoCompleteEntity suggestion) =>
                      ListSuggestionComponent(
                    query: "",
                    suggestion: suggestion,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
