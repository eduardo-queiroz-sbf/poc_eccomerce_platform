import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';

class CheckoutConfirmRoute extends CoreRoute {
  CheckoutConfirmRoute(this.uid);

  static String path = 'checkout/confirm';

  final String uid;
  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de checkout confirmacao',
  );
}
