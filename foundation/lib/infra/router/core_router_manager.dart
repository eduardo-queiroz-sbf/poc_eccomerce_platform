import 'package:flutter/material.dart';
import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/infra/router/transition_type.dart';
import 'package:foundation/interfaces/builders/screens/fallback.dart';

class CoreRouteManager {
  String fallback = FallbackRoute.path;

  RouteBundle checkIfRoutesExists(
    RouteSettings settings,
    Map<String, RouteBundle> routes,
  ) {
    // Check if route is protected (needs login) and redirect to default route if user not logged.
    // if (!routes.containsKey(fallback)) {
    //   throw ErrorDescription(
    //     'A aplicação não possui uma rota de fallback por favor adicione no contexto',
    //   );
    // }

    if (!routes.containsKey(settings.name)) {
      return routes[fallback] ??
          RouteBundle<FallbackRoute, Widget>(
            transitionType: CorePageTransitionType.fade,
          );
    }

    final RouteBundle currentRoute = routes[settings.name]!;

    return currentRoute;
  }
}
