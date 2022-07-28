// ignore_for_file: always_specify_types, cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foundation/interfaces/bloc/bloc_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../interfaces/analytics/event_bundle.dart';
import 'route_provider.dart';
import 'transition_type.dart';

enum CoreRouteTransition {
  faded,
  normal,
  none,
}

class RouteBundle<ParametersType extends CoreRoute, ScreenType extends Widget> {
  RouteBundle({
    required this.transitionType,
    this.event,
    this.providers = const [],
    this.isPrivate,
  });

  final List<Type> providers;

  final getIt = GetIt.instance;
  final EventBundle? event;
  final bool? isPrivate;
  final CorePageTransitionType transitionType;

  // ignore: avoid_annotating_with_dynamic
  bool validateArgs(dynamic args) => args is! ParametersType;

  ParametersType? deeplinkGenerator(Map<String, String>? parameters) =>
      getIt.get<ParametersType>(param1: parameters);

  PageRouteBuilder<ParametersType> createRoute([RouteSettings? settings]) {
    final transition = CorePageTransition<ParametersType>(type: transitionType);
    final List<SingleChildWidget> blocProviders = providers.map((type) {
      return Provider(
        lazy: false,
        create: (_) => getIt.get<BlocInterface>(instanceName: type.toString()),
      );
    }).toList();

    // if (settings?.arguments != null) {
    //   blocProviders.add(Provider<ParametersType>(
    //     create: (_) => settings!.arguments as ParametersType,
    //   ));
    // }

    late ScreenType screen;
    if (settings?.arguments != null) {
      screen = getIt<ScreenType>(param1: settings!.arguments as ParametersType);
    } else {
      screen = getIt<ScreenType>();
    }

    return transition.provider(
      blocProviders.isNotEmpty
          ? MultiProvider(providers: blocProviders, child: screen)
          : screen,
      settings,
    );
  }
}
