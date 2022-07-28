import 'dart:core';

import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class SearchResultRoute extends CoreRoute {
  SearchResultRoute({
    this.name,
    this.query = '',
    String? filterUnformatted,
    this.searchedQueryTag,
    this.cupom,
  });

  @factoryMethod
  static SearchResultRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    if (link == null) throw 'Deeplink invalido';

    return SearchResultRoute(
      cupom: link['cupom'] ?? '',
      query: link['queryString'] ?? '',
    );
  }

  static String path = 'catalogo';

  @override
  String get getPath => path;

  final String? name;
  final String query;
  final String? searchedQueryTag;
  final String? cupom;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de Produto',
  );
}
