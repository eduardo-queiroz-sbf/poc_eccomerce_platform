// ignore_for_file: prefer_typing_uninitialized_variables, always_specify_types,
// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:chopper/chopper.dart';

class JsonToTypeConverter extends JsonConverter {
  const JsonToTypeConverter(this.typeToJsonFactoryMap, [this.customAdapter]);
  final Map<Type, Function> typeToJsonFactoryMap;
  final String Function(String)? customAdapter;
  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) =>
      response.copyWith(
        body: fromJsonData<BodyType, InnerType>(
          response.body.toString(),
          typeToJsonFactoryMap[InnerType],
        ),
      );

  T? fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    var jsonMap;
    String decodedJsonData = jsonData;
    if (customAdapter != null) {
      decodedJsonData = customAdapter!(jsonData);
    }
    try {
      decodedJsonData = utf8.decode(
        jsonData.codeUnits,
      );
    } on Exception catch (_) {}
    try {
      jsonMap = json.decode(decodedJsonData);
      if (jsonParser == null) {
        return jsonMap as T;
      }
    } on Exception catch (_) {}
    if (jsonParser != null) {
      if (jsonMap is List) {
        return jsonMap
            .map(
              (item) => jsonParser(item as Map<String, dynamic>) as InnerType,
            )
            .toList() as T;
      }
      return jsonParser(jsonMap) as T;
    }
    return null;
  }
}
