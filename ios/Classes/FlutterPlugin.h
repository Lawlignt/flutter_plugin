#import <Flutter/Flutter.h>

@interface FlutterPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
@property (nonatomic, strong) FlutterEventSink eventSink;

@end
