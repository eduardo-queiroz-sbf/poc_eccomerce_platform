import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class FallbackRoute extends CoreRoute {
  static String path = '/fallback';

  @override
  String get getPath => path;

  @factoryMethod
  static FallbackRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as FallbackRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou no Fallback',
  );
}
