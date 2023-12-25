import Flutter
import UIKit

public class GameShieldPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "game_shield", binaryMessenger: registrar.messenger())
        let instance = GameShieldPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "initSDK":
            result(self.initSDK(call, result: result))
        case "reinit":
            result(self.reinit())
//        case "addListeningPort":
//            result("iOS " + UIDevice.current.systemVersion)
        case "getClientIP":
            result(self.getClientIP(call, result: result))
        case "getProxyServerIP":
            result(self.getProxyServerIP(call, result: result))
        case "setTimeouts":
            result("iOS " + UIDevice.current.systemVersion)
        case "getServerIPAndPort":
            result(self.getServerIPAndPort(call, result: result))
        case "setCredit":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func initSDK(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Int32 {
        guard let argument = call.arguments as? [String: Any?] else {
          result(FlutterError(code: "0", message: "arg is not map", details: nil))
          return -100
        }
        guard let accessKey = argument["accessKey"] as? String, let uuid = argument["uuid"] as? String else { return -100 }
        return AppvestBridge.sharedInstance().`init`(accessKey, uuid: uuid)
    }
    
    func reinit() -> Int32 {
        return AppvestBridge.sharedInstance().reinit()
    }
    
    func getClientIP(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> String {
        return AppvestBridge.sharedInstance().getClientIP()
    }
    
    func getProxyServerIP(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> String {
        return AppvestBridge.sharedInstance().getProxyServerIP()
    }
    
    func getServerIPAndPort(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> [AnyHashable: Any]? {
        guard let argument = call.arguments as? [String: Any?],
              let host = argument["host"] as? String, let port = argument["port"] as? Int else {
          result(FlutterError(code: "0", message: "arg is not map", details: nil))
          return nil
        }
        return AppvestBridge.sharedInstance().getServerIPAndPort(host, port: Int32(port))
    }
}
