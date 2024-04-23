import UIKit
import Flutter

public class SwiftHiConfigPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.jianxiang.com/hi_config_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftHiConfigPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "baseLink" {
          guard
            let types = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? Array<Dictionary<String, Any>>
          else {
              result(nil)
              return
          }
          let prefix = "app."
          var baseLink: String?
          for info in types {
            if let urlName = info["CFBundleURLName"] as? String, urlName.hasPrefix(prefix) {
                if let urlSchemes = info["CFBundleURLSchemes"] as? [String] {
                    baseLink = (urlSchemes.first ?? "") + String(urlName.dropFirst(prefix.count - 1))
                }
                break
            }
          }
          result(baseLink)
      }
  }
}
