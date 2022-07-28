// ignore_for_file: always_specify_types
import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/infra/router/transition_type.dart';
import 'package:foundation/interfaces/builders/screens/home.dart';
import 'package:foundation/interfaces/router/route_setup_interface.dart';
import 'package:home/screen/home_screen.dart';

class Routes implements RouteSetupInterface {
  @override
  Map<String, RouteBundle> routes = <String, RouteBundle>{
    HomeRoute.path: RouteBundle<HomeRoute, HomeScreen>(
      transitionType: CorePageTransitionType.fade,
    ),
  };
}
