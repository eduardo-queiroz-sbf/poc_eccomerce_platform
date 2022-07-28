import 'package:dartz/dartz.dart';
import 'package:search/data/data_sources/search_autocomplete_datasource_remote.dart';
import 'package:search/data/data_sources/search_topterms_datasource_remote.dart';
import 'package:search/domain/entities/search_autocomplete.dart';
import 'package:search/domain/repositories/autocomplete_repository.dart';

class SearchDataSugestionsRepository
    implements SearchDomainSugestionRepository {
  SearchDataSugestionsRepository(
    this._searchAutoCompleteDataSource,
    this._searchTopTermsDataSource,
  );

  final SearchDataSourceAutoCompleteRemote _searchAutoCompleteDataSource;
  final SearchDataSourceTopTermsRemote _searchTopTermsDataSource;

  @override
  Future<Either<Exception, SearchAutoCompleteEntity>> call(
          String terms) async =>
      terms.isNotEmpty
          ? _searchAutoCompleteDataSource(
              terms: terms,
            )
          : _searchTopTermsDataSource();
}
