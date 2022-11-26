import Flutter
import UIKit

public class SwiftHiSharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.tospery.com/hi_share_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftHiSharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let vc = UIActivityViewController(
        activityItems: [
            "分享内容的标题",
            URL(string: "https://github.com/tospery/flutter_hub")!
        ],
        applicationActivities: nil
    )
    UIApplication.shared.keyWindow!.rootViewController?.present(vc, animated: true, completion: nil)
    result(false)
  }
}
