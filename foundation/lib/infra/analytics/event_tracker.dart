import 'package:flutter/foundation.dart';
import 'package:foundation/interfaces/analytics/tap_analytics_interface.dart';
import 'package:get_it/get_it.dart';
import '../../interfaces/analytics/event_bundle.dart';

GetIt getIt = GetIt.instance;

class EventTracker {
  static void eventScreen(EventBundle event) async {
    List<Function(EventBundle)> setupImp = [];
    int currentSetupImp = 0;

    while (true) {
      if (getIt.isRegistered<TapAnalyticsInterface>(
          instanceName: currentSetupImp.toString())) {
        setupImp.add(getIt<TapAnalyticsInterface>(
                instanceName: currentSetupImp.toString())
            .send);
        currentSetupImp++;
      } else {
        for (var currentSetup in setupImp) {
          await currentSetup(event);
        }
        break;
      }
    }
  }
}
