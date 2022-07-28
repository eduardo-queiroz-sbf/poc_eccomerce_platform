import 'package:search/domain/entities/search_query.dart';

class SearchQueryModel extends SearchQueryEntity {
  SearchQueryModel(
    super.query,
    super.link,
  );

  static fromJson(Map<String, dynamic> json) => SearchQueryModel(
        json['query'] as String,
        json['link'] as String,
      );
}
