import Flutter
import UIKit

public class SwiftHiSharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.jianxiang.com/hi_share_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftHiSharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "show" {
          guard
            let root = UIApplication.shared.keyWindow?.rootViewController,
            let items = call.arguments as? [Any] /*, items.count == 3*/
          else {
              result(nil)
              return
          }
          // let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
          let vc = UIActivityViewController(activityItems: ["分享的标题"], applicationActivities: nil)
          root.present(vc, animated: true) {
              result("完成")
          }
      }
  }
}
