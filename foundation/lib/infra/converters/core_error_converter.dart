// ignore_for_file: always_specify_types, avoid_dynamic_calls

import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../interfaces/exceptions/http_exception.dart';

const String _error401 = 'Usuário não autenticado';
const String _error403 = 'Acesso negado';
const String _error500 = 'Houve algum erro no servidor';

@immutable
class CoreErrorConverter implements ErrorConverter {
  const CoreErrorConverter();

  Response decodeJson<BodyType, InnerType>(Response response) {
    final supportedContentTypes = [jsonHeaders, jsonApiHeaders];

    final contentType = response.headers[contentTypeKey];
    dynamic body = response.body;
    String? errorMessage;

    if (supportedContentTypes.contains(contentType)) {
      body = utf8.decode(response.bodyBytes);
    }

    body = _tryDecodeJson(body.toString());
    if (isTypeOf<BodyType, Iterable<InnerType>>()) {
      body = body.cast<InnerType>();
    } else if (isTypeOf<BodyType, Map<String, InnerType>>()) {
      body = body.cast<String, InnerType>();
    }

    if (body.runtimeType.toString().contains('Map')) {
      body = body as Map;

      if (body.containsKey('error')) {
        errorMessage = body['error'].toString();
      } else if (body.containsKey('message')) {
        errorMessage = body['message'].toString();
      }
    }

    if (body.runtimeType == String) {
      errorMessage = Bidi.stripHtmlIfNeeded(body.toString());
    }

    if (response.statusCode == 401) {
      errorMessage = _error401;
    } else if (response.statusCode == 403) {
      errorMessage = _error403;
    } else if (response.statusCode == 500) {
      errorMessage = _error500;
    } else if (response.statusCode != 200) {
      if (body.runtimeType == List) {
        errorMessage = (body as List).join('\n');
      }
    }

    if (errorMessage != null) {
      throw HttpException(errorMessage);
    }

    return response;
  }

  dynamic _tryDecodeJson(String data) {
    try {
      return json.decode(data);
    } on Exception catch (e) {
      chopperLogger.warning(e);
      return data;
    }
  }

  @override
  Response convertError<BodyType, InnerType>(Response response) =>
      decodeJson(response);
}
