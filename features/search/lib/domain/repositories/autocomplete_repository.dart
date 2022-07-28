import 'package:dartz/dartz.dart';
import 'package:search/domain/entities/search_autocomplete.dart';

abstract class SearchDomainSugestionRepository {
  Future<Either<Exception, SearchAutoCompleteEntity>> call(String terms);
}
