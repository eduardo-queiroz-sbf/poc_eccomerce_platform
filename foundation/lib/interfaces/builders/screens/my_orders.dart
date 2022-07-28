import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class OrdersRoute extends CoreRoute {
  static String path = '/my_orders';

  @override
  String get getPath => path;

  @factoryMethod
  static OrdersRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as OrdersRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou no meus pedidos',
  );
}
