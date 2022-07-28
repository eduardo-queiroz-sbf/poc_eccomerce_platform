import 'package:foundation/infra/router/route_bundle.dart';

abstract class RouteSetupInterface {
  final Map<String, RouteBundle> routes;

  RouteSetupInterface(this.routes);
}
