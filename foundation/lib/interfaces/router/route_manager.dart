// ignore_for_file: always_specify_types

import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:flutter/material.dart';

abstract class RouteManagerInterface {
  Route<dynamic> generateRoute(
    RouteSettings settings,
    Map<String, RouteBundle> routes,
  );

  void showErrorDialog(BuildContext context, [VoidCallback? action]);

  CoreRoute? validateDeeplink(
      String path, Map<String, String> link, BuildContext context);

  bool validateRoute(BuildContext context, CoreRoute route);
}
