import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class FavoritesRoute extends CoreRoute {
  static String path = '/favorites';

  @override
  String get getPath => path;

  @factoryMethod
  static FavoritesRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as FavoritesRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página Favoritos',
  );
}
