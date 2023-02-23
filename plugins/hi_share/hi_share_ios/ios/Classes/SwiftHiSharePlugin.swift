import Flutter
import UIKit

public class SwiftHiSharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.jianxiang.com/hi_share_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftHiSharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     let vc = UIActivityViewController(
//         activityItems: [
//             "分享内容的标题",
//             URL(string: "https://github.com/tospery/flutter_hub")!
//         ],
//         applicationActivities: nil
//     )
//     UIApplication.shared.keyWindow!.rootViewController?.present(vc, animated: true, completion: nil)
//     result(false)
      result("ios result -> \(call.method), \(String(describing: call.arguments))")
  }
}
