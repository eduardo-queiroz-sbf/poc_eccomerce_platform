import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';

class CheckoutPaymentRoute extends CoreRoute {
  static String path = 'checkout/payment';

  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de checkout pagamento',
  );
}
