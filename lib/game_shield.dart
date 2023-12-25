import 'package:game_shield/game_shield_model.dart';

import 'game_shield_platform_interface.dart';

class GameShield {
  static Future<dynamic> initSDK(String accessKey, String uuid) async {
    return GameShieldPlatform.instance.initSDK(accessKey, uuid);
  }

  static Future<String?> getClientIP() async {
    return GameShieldPlatform.instance.getClientIP();
  }

  static Future<String?> getProxyServerIP() async {
    return GameShieldPlatform.instance.getProxyServerIP();
  }

  static Future<GameShieldModel?> getServerIPAndPort(
      String host, int port) async {
    return GameShieldPlatform.instance.getServerIPAndPort(host, port);
  }
}
