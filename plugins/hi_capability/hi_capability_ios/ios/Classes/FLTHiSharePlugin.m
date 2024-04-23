#import "FLTHiSharePlugin.h"
#if __has_include(<hi_share_ios/hi_share_ios-Swift.h>)
#import <hi_share_ios/hi_share_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hi_share_ios-Swift.h"
#endif

@implementation FLTHiSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHiSharePlugin registerWithRegistrar:registrar];
}
@end
