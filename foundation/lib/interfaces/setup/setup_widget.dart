import 'package:flutter/foundation.dart';
import 'package:fairplay_ds/core/core_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:foundation/infra/router/route_bundle.dart';
import 'package:foundation/interfaces/router/app_route_interface.dart';
import 'package:foundation/interfaces/router/route_setup_interface.dart';
import 'package:foundation/interfaces/router/route_manager.dart';
import 'package:foundation/interfaces/setup/app_setup_interface.dart';
import 'package:foundation/interfaces/theme/custom_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foundation/interfaces/setup/feature_setup_interface.dart';

class FoundationSetupType {
  FoundationSetupType({
    required this.title,
    required this.initialRoute,
    required this.theme,
    required this.routeManager,
  });

  final String title;
  final String initialRoute;
  final CustomThemeInterface theme;
  final RouteFactory routeManager;
}

class FoundationSetup extends StatefulWidget {
  const FoundationSetup(this.locator, this.splash);

  final Widget splash;
  final AsyncCallback locator;

  @override
  FoundationSetupState createState() => FoundationSetupState();
}

class FoundationSetupState extends State<FoundationSetup> {
  final GlobalKey _appKey = GlobalKey();
  late Future<FoundationSetupType> setupSingleton;
  late Future<void> setupLocator;
  final GetIt getIt = GetIt.instance;

  Widget splashScreen() => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget.splash,
      );

  Future<void> setupFeatures() async {
    List<Function()> setupImp = [];
    int currentSetupImp = 0;

    while (getIt.isRegistered<FeatureSetupInterface>(
      instanceName: currentSetupImp.toString(),
    )) {
      setupImp.add(getIt<FeatureSetupInterface>(
        instanceName: currentSetupImp.toString(),
      ).setup);
      currentSetupImp++;
    }

    for (var currentSetup in setupImp) {
      await currentSetup();
    }
  }

  Future<Map<String, RouteBundle>> setupRoutes() async {
    Map<String, RouteBundle> setupRoutesImp = {};
    int currentSetupImp = 0;
    while (getIt.isRegistered<RouteSetupInterface>(
        instanceName: currentSetupImp.toString())) {
      setupRoutesImp.addAll(
          getIt<RouteSetupInterface>(instanceName: currentSetupImp.toString())
              .routes);
      currentSetupImp++;
    }

    getIt.registerSingleton<AppRoutesInterface>(
      AppRoutesInterface(setupRoutesImp),
    );

    await getIt.allReady();

    return setupRoutesImp;
  }

  Future<FoundationSetupType> setupFunc() async {
    await getIt.allReady();
    await setupFeatures();
    final routes = await setupRoutes();
    final setupApp = getIt<AppSetupInterface>();
    final theme = getIt<CustomThemeInterface>();
    final routerManager = getIt<RouteManagerInterface>();

    return FoundationSetupType(
      title: setupApp.environments[EnvironmentsSetup.dev]!.appName,
      initialRoute: setupApp.environments[EnvironmentsSetup.dev]!.initialRoute,
      theme: theme,
      routeManager: (settings) => routerManager.generateRoute(settings, routes),
    );
  }

  @override
  void initState() {
    setupSingleton = setupFunc();
    setupLocator = widget.locator();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoreFutureBuilder<void>(
      load: () => setupLocator,
      done: (_) => CoreFutureBuilder<FoundationSetupType>(
        load: () => setupSingleton,
        done: (FoundationSetupType value) => MaterialApp(
          key: _appKey,
          debugShowCheckedModeBanner: false,
          title: value.title,
          theme: value.theme.values,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const <Locale>[
            Locale('pt', 'BR'),
          ],
          onGenerateRoute: value.routeManager,
          initialRoute: value.initialRoute,
        ),
        loading: splashScreen(),
      ),
      loading: splashScreen(),
    );
  }
}
