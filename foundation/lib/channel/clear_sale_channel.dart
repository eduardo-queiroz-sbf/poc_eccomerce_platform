import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

const String kClearSaleChannel = 'clear_sale_plugin';
const String kClearSaleGetSessionId = 'getSessionId';

@injectable
class ClearSaleChannel {
  ClearSaleChannel(
    @factoryParam MethodChannel? channel,
  ) : channel = channel ?? const MethodChannel(kClearSaleChannel);

  final MethodChannel channel;

  Future<String> getSessionId() async {
    final String? token =
        await channel.invokeMethod<String>(kClearSaleGetSessionId);
    if (token != null) {
      return token;
    } else {
      throw 'Houve problemas internos';
    }
  }
}
