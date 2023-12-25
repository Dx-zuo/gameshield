import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:game_shield/game_shield_model.dart';

import 'game_shield_platform_interface.dart';

/// An implementation of [GameShieldPlatform] that uses method channels.
class MethodChannelGameShield extends GameShieldPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('game_shield');

  Future<dynamic> initSDK(String accessKey, String uuid) async {
    final result =
        await methodChannel.invokeMethod<dynamic>('initSDK', <String, dynamic>{
      'accessKey': accessKey,
      'uuid': uuid,
    });
    return result;
  }

  Future<String?> getClientIP() async {
    final result = await methodChannel.invokeMethod<String>('getClientIP');
    return result;
  }

  Future<String?> getProxyServerIP() async {
    final result = await methodChannel.invokeMethod<String>('getProxyServerIP');
    return result;
  }

  Future<GameShieldModel?> getServerIPAndPort(String host, int port) async {
    final result = await methodChannel
        .invokeMethod<dynamic>('getServerIPAndPort', <String, dynamic>{
      'host': host,
      'port': port,
    });
    if (result is Map) {
      try {
        var ip = result['ip'];
        var port = result['port'];
        return GameShieldModel(ip: ip, port: port);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
