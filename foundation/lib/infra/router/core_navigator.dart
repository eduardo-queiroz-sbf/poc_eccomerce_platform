import 'package:flutter/material.dart';
import 'package:foundation/interfaces/router/route_manager.dart';
import 'package:get_it/get_it.dart';

import 'route_provider.dart';

class CoreNavigator {
  final GetIt getIt = GetIt.instance;
  CoreNavigator.of(this.context) : flutterNavigator = Navigator.of(context);

  final BuildContext context;

  final NavigatorState flutterNavigator;

  void pushNamed(CoreRoute route) {
    if (getIt<RouteManagerInterface>().validateRoute(context, route)) {
      flutterNavigator.pushNamed(route.getPath, arguments: route);
    }
  }

  void pushDeeplink(String link) {
    final Uri uri = UriData.fromString(link).uri;
    final CoreRoute? params = getIt<RouteManagerInterface>().validateDeeplink(
      uri.pathSegments.last,
      uri.queryParameters,
      context,
    );
    if (params != null) {
      flutterNavigator.pushNamed(
        uri.pathSegments.last,
        arguments: params,
      );
    }
  }

  void pushReplacementNamed(CoreRoute route) {
    if (getIt<RouteManagerInterface>().validateRoute(context, route)) {
      flutterNavigator.pushReplacementNamed(route.getPath, arguments: route);
    }
  }

  void popAndPushNamed(CoreRoute route) {
    if (getIt<RouteManagerInterface>().validateRoute(context, route)) {
      flutterNavigator.pushReplacementNamed(route.getPath, arguments: route);
    }
  }

  void pushNamedAndRemoveUntil(CoreRoute route, {String? routeRemove}) {
    if (getIt<RouteManagerInterface>().validateRoute(context, route)) {
      flutterNavigator.pushNamedAndRemoveUntil(
        route.getPath,
        (Route<dynamic> route) => route.settings.name == routeRemove,
        arguments: route,
      );
    }
  }

  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) {
    flutterNavigator.pop<T>(result);
  }
}
