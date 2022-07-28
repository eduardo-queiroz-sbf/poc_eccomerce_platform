import 'package:foundation/interfaces/analytics/event_bundle.dart';
import 'package:foundation/infra/router/route_provider.dart';
import 'package:injectable/injectable.dart';

class PdpRoute implements CoreRoute {
  PdpRoute({
    required this.modelCode,
    required this.colorCode,
    this.cupom,
    this.url,
    this.favoriteReload,
  });

  final String? url;
  final String modelCode;
  final String colorCode;
  final String? cupom;
  // Função utilizada para recarregar a lista de favoritos, caso exista
  final Function? favoriteReload;

  static String path = 'pdp';

  @factoryMethod
  static PdpRoute factoryDeeplink(
    @factoryParam Map<String, String>? link,
  ) {
    if (link == null) throw 'Query string é obrigatoria';
    return PdpRoute(
      modelCode: link['sku']!.substring(0, 6),
      colorCode: link['sku']!.substring(6, 7),
      cupom: link['cupom'],
    );
  }

  @override
  String get getPath => path;

  @override
  EventBundle event = EventBundle(
    name: 'Entrou na página de Produto',
  );
}
