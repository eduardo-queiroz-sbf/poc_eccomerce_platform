import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';

class WebviewRoute implements CoreRoute {
  WebviewRoute({
    required this.url,
  });

  final String url;

  static String path = '/webview';

  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de Webview',
  );
}
