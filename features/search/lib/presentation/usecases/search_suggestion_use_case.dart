import 'package:dartz/dartz.dart';
import 'package:foundation/interfaces/bloc/bloc_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foundation/interfaces/builders/screens/search.dart';
import 'package:injectable/injectable.dart';
import 'package:search/domain/entities/search_autocomplete.dart';
import 'package:search/domain/repositories/autocomplete_repository.dart';

class SearchQueryState {
  SearchQueryState();

  factory SearchQueryState.initial() {
    return SearchQueryState();
  }
}

abstract class SearchQueryEvent {}

class SearchSuggestionUseCase extends Bloc<SearchQueryEvent, SearchQueryState>
    implements BlocInterface {
  SearchSuggestionUseCase(
    // @factoryParam this.args,
    this.dataSource,
  ) : super(SearchQueryState.initial());

  // final SearchRoute args;
  final SearchDomainSugestionRepository dataSource;

  Future<Either<Exception, SearchAutoCompleteEntity>> getSuggestion(
      String inputValue) async {
    return (await dataSource.call(inputValue));
  }
}
