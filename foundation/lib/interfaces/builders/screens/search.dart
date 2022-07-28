import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class SearchRoute extends CoreRoute {
  SearchRoute({
    this.initialQuery,
    this.searchedQueryTag,
  });

  @factoryMethod
  static SearchRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as SearchRoute;
  }

  static String path = '/search';

  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de Busca',
  );

  final String? initialQuery;
  final String? searchedQueryTag;
}
