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
            let arguments = call.arguments as? [Any]
          else {
              result(nil)
              return
          }
          var items = [Any].init()
          for (index, argument) in arguments.enumerated() {
              if index == 0 {
                  if let title = argument as? String {
                      items.append(title)
                  }
              } else if index == 1 {
                  if let data = (argument as? FlutterStandardTypedData)?.data,
                     let image = UIImage.init(data: data) {
                      items.append(image)
                  }
              } else if index == 2 {
                  if let string = argument as? String,
                     let url = URL(string: string) {
                      items.append(url)
                  }
              }
          }
          let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
          root.present(vc, animated: true) {
              result("完成")
          }
      }
  }
}
