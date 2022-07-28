import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:search/data/models/request/search_autocomplete.dart';
import 'package:search/domain/entities/search_autocomplete.dart';

class SearchDataSourceTopTermsRemote {
  @override
  Future<Either<Exception, SearchAutoCompleteEntity>> call() async {
    try {
      var response = await Dio().get(
        'https://gateway.plataforma.centauro.com.br/yantar/api/topterms',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImZyb250LWVuZCBjZW50YXVybyIsIm5iZiI6MTU4OTkxOTgxMywiZXhwIjoxOTA1NDUyNjEzLCJpYXQiOjE1ODk5MTk4MTN9.YeCTBYcWozaQb4MnILtfeKTeyCwApNgLSOfGeVVM8D0',
            'x-cv-id': '14',
          },
        ),
      );

      final SearchAutoCompleteModel identity =
          SearchAutoCompleteModel.fromJson(response.data);

      return Right<Exception, SearchAutoCompleteModel>(identity);
    } on Exception catch (e) {
      return Left<Exception, SearchAutoCompleteModel>(e);
    }
  }
}
