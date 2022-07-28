import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class HomeRoute extends CoreRoute {
  static String path = '/';

  @override
  String get getPath => path;

  @factoryMethod
  static HomeRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as HomeRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página Home',
  );
}
