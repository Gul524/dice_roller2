import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  // Developer / legal constants — update these before publishing
  static const String developerName = 'Suleman Gul';
  static const String developerEmail = 'gullsuleman524@gmail.com';
  static const String privacyPolicyUrl =
      'https://github.com/Gul524/Private-Polices/blob/main/Dice%20Roller';
  static const String packageId = 'com.sulemangul.dice_roller';

  static Future<String> versionLabel() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    if (buildNumber.isEmpty || buildNumber == '0') {
      return 'v$version';
    }

    return 'v$version ($buildNumber)';
  }
}
