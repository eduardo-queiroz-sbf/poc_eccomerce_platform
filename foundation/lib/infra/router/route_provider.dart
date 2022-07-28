import '../../interfaces/analytics/event_bundle.dart';

abstract class CoreRoute {
  static CoreRoute factoryDeeplink(
    Map<String, String>? parameters,
  ) {
    throw Exception('Deeplink nao implementado');
  }

  static String path = '';
  String get getPath => path;

  late EventBundle event;
}
