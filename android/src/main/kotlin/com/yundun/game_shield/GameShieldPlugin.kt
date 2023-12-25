package com.yundun.game_shield

import androidx.annotation.NonNull
import com.cf.msc.sdk.AppVest

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GameShieldPlugin */
class GameShieldPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "game_shield")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "initSDK") {
      val accessKey = call.argument<String>("accessKey")
      val uuid = call.argument<String>("uuid")
      if (accessKey != null && uuid != null) {
        val res = AppVest.init(accessKey, uuid)
        if (res == -1) {
          println("AppVest 初始化失败")
          result.notImplemented()
        } else {
          println("AppVest 初始化成功")
          result.success(0);
        }
      }
    } else if (call.method == "getClientIP") {
      result.success(AppVest.getClientIP());
    } else if (call.method == "getProxyServerIP") {
      result.success(AppVest.getProxyServerIP());
    } else if (call.method == "getServerIPAndPort") {
      val host = call.argument<String>("host")
      val port = call.argument<Int>("port")
        if (host != null && port != null) {
          val conn = AppVest.getServerIPAndPort(host, port);
          if (conn.serverPort == -1) {
            result.notImplemented()
          }
          result.success(mapOf("ip" to conn.serverIp, "port" to conn.serverPort))
        }
      } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
