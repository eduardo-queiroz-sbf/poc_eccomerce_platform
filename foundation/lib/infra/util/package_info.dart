import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtil {
  static Future<String> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;

    return version;
  }

  static Future<String> getPackageName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String packageName = packageInfo.packageName;

    return packageName;
  }

  static Future<String> getBuildNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String buildNumber = packageInfo.buildNumber;

    return buildNumber;
  }
}
