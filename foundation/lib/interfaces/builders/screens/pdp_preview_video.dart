import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';

class PdpVideoPreviewRoute implements CoreRoute {
  PdpVideoPreviewRoute({
    required this.videoCode,
  });

  static String path = '/pdp-video-preview';

  @override
  String get getPath => path;

  final String videoCode;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de Video',
  );
}
