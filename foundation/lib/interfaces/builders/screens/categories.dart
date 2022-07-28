import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class CategoriesRoute extends CoreRoute {
  static String path = '/categories';

  @override
  String get getPath => path;

  @factoryMethod
  static CategoriesRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as CategoriesRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página Categorias',
  );
}
