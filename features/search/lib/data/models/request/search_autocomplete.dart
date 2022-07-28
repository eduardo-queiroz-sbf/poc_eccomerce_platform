import 'package:search/data/models/request/search_query.dart';
import 'package:search/domain/entities/search_autocomplete.dart';

class SearchAutoCompleteModel extends SearchAutoCompleteEntity {
  SearchAutoCompleteModel(
    super.requestId,
    super.searchId,
    super.queries,
  );

  static fromJson(Map<String, dynamic> json) => SearchAutoCompleteModel(
        json['requestId'] as String,
        json['searchId'] as String,
        (json['queries'] as List<dynamic>)
            .map<SearchQueryModel>(
              (e) => SearchQueryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
}
