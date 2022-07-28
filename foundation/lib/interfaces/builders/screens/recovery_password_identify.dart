import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class RecoveryPasswordIdentifyRoute extends CoreRoute {
  RecoveryPasswordIdentifyRoute();

  static String path = '/recovery-password/identify';

  @override
  String get getPath => path;

  @factoryMethod
  static RecoveryPasswordIdentifyRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as RecoveryPasswordIdentifyRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de informar e-mail para recuperação de senha',
  );
}
