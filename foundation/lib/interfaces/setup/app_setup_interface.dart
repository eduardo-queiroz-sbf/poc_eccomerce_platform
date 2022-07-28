import 'package:flutter/material.dart';

class EnvironmentsSetup {
  static String prd = "prd";
  static String dev = "dev";

  static bool validValues(String value) {
    return value == prd || value == dev;
  }
}

class AppSetupTypeInterface {
  final String appName;
  final String initialRoute;

  final String cvId;
  final String apiHost;
  final String apiToken;

  //auth environment
  final String authApi;
  final String authApiToken;

  //search environment
  final String searchApi;
  final String searchApiToken;

  //generic keys environment
  final String keyCloak;
  final String googleMapsKey;

  //webviews links environment
  final String webviewUrlPdpInfo;
  final String webviewUrlSearchPostalCode;

  AppSetupTypeInterface({
    required this.appName,
    required this.initialRoute,
    required this.cvId,
    required this.apiHost,
    required this.apiToken,
    required this.authApi,
    required this.authApiToken,
    required this.searchApi,
    required this.searchApiToken,
    required this.keyCloak,
    required this.googleMapsKey,
    required this.webviewUrlPdpInfo,
    required this.webviewUrlSearchPostalCode,
  });
}

abstract class AppSetupInterface {
  final Map<String, AppSetupTypeInterface> environments;

  AppSetupInterface(this.environments);
}
