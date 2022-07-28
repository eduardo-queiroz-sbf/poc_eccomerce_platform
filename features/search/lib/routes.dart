// ignore_for_file: always_specify_types
import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/infra/router/transition_type.dart';
import 'package:foundation/interfaces/builders/screens/search.dart';
import 'package:foundation/interfaces/router/route_setup_interface.dart';
import 'package:search/presentation/screens/search_screen.dart';
import 'package:search/presentation/usecases/search_suggestion_use_case.dart';

class Routes implements RouteSetupInterface {
  @override
  Map<String, RouteBundle> routes = <String, RouteBundle>{
    SearchRoute.path: RouteBundle<SearchRoute, SearchScreen>(
      transitionType: CorePageTransitionType.fade,
      providers: [SearchSuggestionUseCase],
    ),
  };
}
