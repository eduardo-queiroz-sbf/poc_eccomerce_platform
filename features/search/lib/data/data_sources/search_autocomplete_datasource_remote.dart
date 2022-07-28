import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:search/data/models/request/search_autocomplete.dart';
import 'package:search/domain/entities/search_autocomplete.dart';

class SearchDataSourceAutoCompleteRemote {
  @override
  Future<Either<Exception, SearchAutoCompleteEntity>> call({
    required String terms,
  }) async {
    try {
      var response = await Dio().get('/autocomplete?terms=$terms');

      final dynamic data = response.data;
      final SearchAutoCompleteModel identity =
          SearchAutoCompleteModel.fromJson(jsonDecode(data));

      return Right<Exception, SearchAutoCompleteModel>(identity);
    } on Exception catch (e) {
      return Left<Exception, SearchAutoCompleteModel>(e);
    }
  }
}
