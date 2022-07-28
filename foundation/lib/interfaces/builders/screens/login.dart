import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class LoginRoute extends CoreRoute {
  LoginRoute(this.onSuccess);

  static String path = '/Login';

  final Function(BuildContext) onSuccess;

  @override
  String get getPath => path;

  @factoryMethod
  static LoginRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    //dont have a deeplink implementation
    return CoreRoute.factoryDeeplink(link) as LoginRoute;
  }

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página Login',
  );
}
