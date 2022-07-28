import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:foundation/infra/router/core_router_manager.dart';
import 'package:foundation/infra/router/core_navigator.dart';
import 'package:flutter/material.dart';
import 'package:foundation/interfaces/builders/screens/login.dart';
import 'package:foundation/interfaces/router/route_manager.dart';
import 'dart:io';

import 'package:fairplay_ds/core/core_alert_dialog.dart';
import 'package:fairplay_ds/core/core_button.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:foundation/interfaces/builders/screens/home.dart';
import 'package:foundation/interfaces/router/app_route_interface.dart';
import 'package:get_it/get_it.dart';

class RouteManager extends CoreRouteManager implements RouteManagerInterface {
  final GetIt getIt = GetIt.instance;
  @override
  Route<dynamic> generateRoute(
    RouteSettings settings,
    Map<String, RouteBundle> routes,
  ) {
    final currentRoute = checkIfRoutesExists(
      settings,
      routes,
    );

    if (currentRoute.isPrivate != null && currentRoute.isPrivate == true) {
      final String? token = null;
      if (token == null) {
        return routes[LoginRoute.path]!.createRoute(
          settings.copyWith(
            arguments: LoginRoute(
              (context) {
                final route = settings.arguments as CoreRoute;
                Navigator.of(context).popAndPushNamed(
                  route.getPath,
                  arguments: route,
                );
              },
            ),
          ),
        );
      }
    }

    return currentRoute.createRoute(settings);
  }

  @override
  void showErrorDialog(BuildContext context, [VoidCallback? action]) {
    showDialog<void>(
      context: context,
      builder: (_) => CoreAlertDialog(
        title: const CoreTypography.bodyText1('Erro'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CoreTypography.bodyText2Normal(
              'Parece que alguma informação está incompleta, ou o recurso que está tentando acessar não existe mais.',
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: CoreButton.elevated(
                onPress: () async {
                  (action ?? CoreNavigator.of(context).pop).call();
                },
                content: 'Ok',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CoreRoute? validateDeeplink(
      String path, Map<String, String> link, BuildContext context) {
    try {
      return getIt<AppRoutesInterface>().routes[path]!.deeplinkGenerator(link);
    } catch (e) {
      showErrorDialog(
        context,
        () => CoreNavigator.of(context).popAndPushNamed(HomeRoute()),
      );
      return null;
    }
  }

  @override
  bool validateRoute(BuildContext context, CoreRoute route) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return true;
    }

    if (getIt<AppRoutesInterface>()
        .routes[route.getPath]!
        .validateArgs(route)) {
      showErrorDialog(context);
      return false;
    }
    return true;
  }
}
