import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/interfaces/analytics/tap_analytics_interface.dart';

class FirebaseScreenAnalytics implements TapAnalyticsInterface {
  void send(EventBundle teste) {
    print(teste.name);
  }
}
