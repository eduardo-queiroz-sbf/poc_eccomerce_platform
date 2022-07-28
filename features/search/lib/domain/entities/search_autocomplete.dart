import 'package:search/domain/entities/search_query.dart';

class SearchAutoCompleteEntity {
  SearchAutoCompleteEntity(
    this.requestId,
    this.searchId,
    this.queries,
  );

  String requestId;
  String searchId;
  List<SearchQueryEntity> queries;
}
