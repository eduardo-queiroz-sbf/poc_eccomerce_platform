import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './locator.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> setupLocator() {
  $initGetIt(getIt);
  return GetIt.I.allReady();
}
