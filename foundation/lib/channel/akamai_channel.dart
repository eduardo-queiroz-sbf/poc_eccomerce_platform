import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

const String kAkamaiChannel = 'akamai_plugin';
const String kAkamaiGetToken = 'getToken';

@injectable
class AkamaiChannel {
  AkamaiChannel(
    @factoryParam MethodChannel? channel,
  ) : channel = channel ?? const MethodChannel(kAkamaiChannel);

  final MethodChannel channel;
  Future<String> getToken() async {
    final String? token = await channel.invokeMethod<String>(kAkamaiGetToken);
    if (token != null) {
      return token;
    } else {
      throw 'Houve problemas internos';
    }
  }
}
