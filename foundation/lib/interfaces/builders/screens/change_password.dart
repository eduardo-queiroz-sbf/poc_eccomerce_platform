import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class ChangePasswordRoute extends CoreRoute {
  static String path = '/change-password';

  @override
  String get getPath => path;

  @factoryMethod
  static ChangePasswordRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as ChangePasswordRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de alteração de senha',
  );
}
