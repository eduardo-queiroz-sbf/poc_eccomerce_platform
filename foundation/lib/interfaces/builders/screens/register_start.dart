import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class RegisterStartRoute extends CoreRoute {
  static String path = '/register';

  @override
  String get getPath => path;

  @factoryMethod
  static RegisterStartRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as RegisterStartRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou em criar conta - Start',
  );
}
