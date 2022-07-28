import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';

class CheckoutDeliveryRoute extends CoreRoute {
  CheckoutDeliveryRoute({
    required this.addressId,
  });

  final int addressId;

  static String path = 'checkout/delivery';

  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de checkout delivery',
  );
}
