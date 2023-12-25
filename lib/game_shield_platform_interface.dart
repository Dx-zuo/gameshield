import 'package:game_shield/game_shield_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'game_shield_method_channel.dart';

abstract class GameShieldPlatform extends PlatformInterface {
  /// Constructs a GameShieldPlatform.
  GameShieldPlatform() : super(token: _token);

  static final Object _token = Object();

  static GameShieldPlatform _instance = MethodChannelGameShield();

  /// The default instance of [GameShieldPlatform] to use.
  ///
  /// Defaults to [MethodChannelGameShield].
  static GameShieldPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GameShieldPlatform] when
  /// they register themselves.
  static set instance(GameShieldPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<dynamic> initSDK(String accessKey, String uuid) async {
    throw UnimplementedError('initSDK() has not been implemented.');
  }

  Future<String?> getClientIP() async {
    throw UnimplementedError('getClientIP() has not been implemented.');
  }

  Future<String?> getProxyServerIP() async {
    throw UnimplementedError('getProxyServerIP() has not been implemented.');
  }

  Future<GameShieldModel?> getServerIPAndPort(String host, int port) {
    throw UnimplementedError('getServerIPAndPort() has not been implemented.');
  }
}
