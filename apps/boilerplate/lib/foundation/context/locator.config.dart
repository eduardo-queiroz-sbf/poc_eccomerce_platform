// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: FoundationConfig
// **************************************************************************

import 'package:foundation/interfaces/bloc/bloc_interface.dart' as _i24;
import 'package:foundation/interfaces/builders/containers/search_header_builder.dart'
    as _i20;
import 'package:foundation/interfaces/builders/screens/search.dart' as _i23;
import 'package:foundation/interfaces/router/route_manager.dart' as _i11;
import 'package:foundation/interfaces/router/route_setup_interface.dart'
    as _i13;
import 'package:foundation/interfaces/setup/app_setup_interface.dart' as _i3;
import 'package:foundation/interfaces/setup/feature_setup_interface.dart'
    as _i7;
import 'package:foundation/interfaces/theme/custom_theme.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:home/routes.dart' as _i14;
import 'package:home/screen/home_screen.dart' as _i10;
import 'package:home/setup.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:search/data/data_sources/search_autocomplete_datasource_remote.dart'
    as _i16;
import 'package:search/data/data_sources/search_topterms_datasource_remote.dart'
    as _i17;
import 'package:search/data/repositories/autocomplete_repository.dart' as _i19;
import 'package:search/domain/repositories/autocomplete_repository.dart'
    as _i18;
import 'package:search/presentation/screens/search_screen.dart' as _i22;
import 'package:search/presentation/usecases/search_suggestion_use_case.dart'
    as _i25;
import 'package:search/routes.dart' as _i15;
import 'package:search/setup.dart' as _i9;

import '../../features/search/presentation/container/header.dart' as _i21;
import '../../setup.dart' as _i4;
import '../../theme/theme.dart' as _i6;
import '../router/route_manager.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AppSetupInterface>(_i4.SetupEnv());
  gh.factory<_i5.CustomThemeInterface>(() => _i6.CustomTheme());
  gh.factory<_i7.FeatureSetupInterface>(() => _i8.Setup(), instanceName: '0');
  gh.factory<_i7.FeatureSetupInterface>(() => _i9.Setup(), instanceName: '1');
  gh.factory<_i10.HomeScreen>(() => _i10.HomeScreen());
  gh.singleton<_i11.RouteManagerInterface>(_i12.RouteManager());
  gh.factory<_i13.RouteSetupInterface>(() => _i14.Routes(), instanceName: '0');
  gh.factory<_i13.RouteSetupInterface>(() => _i15.Routes(), instanceName: '1');
  gh.singleton<_i16.SearchDataSourceAutoCompleteRemote>(
      _i16.SearchDataSourceAutoCompleteRemote());
  gh.singleton<_i17.SearchDataSourceTopTermsRemote>(
      _i17.SearchDataSourceTopTermsRemote());
  gh.singleton<_i18.SearchDomainSugestionRepository>(
      _i19.SearchDataSugestionsRepository(
          get<_i16.SearchDataSourceAutoCompleteRemote>(),
          get<_i17.SearchDataSourceTopTermsRemote>()));
  gh.singleton<_i20.SearchHeaderContainerInterface>(
      _i21.SearchHeaderContainer());
  gh.factoryParam<_i22.SearchScreen, _i23.SearchRoute, dynamic>(
      (routeParams, _) => _i22.SearchScreen(routeParams));
  gh.factory<_i24.BlocInterface>(
      () => _i25.SearchSuggestionUseCase(
          get<_i18.SearchDomainSugestionRepository>()),
      instanceName: 'SearchSuggestionUseCase');
  return get;
}
