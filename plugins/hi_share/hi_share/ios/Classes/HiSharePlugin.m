#import "HiSharePlugin.h"
#if __has_include(<hi_share/hi_share-Swift.h>)
#import <hi_share/hi_share-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hi_share-Swift.h"
#endif

@implementation HiSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHiSharePlugin registerWithRegistrar:registrar];
}
@end
