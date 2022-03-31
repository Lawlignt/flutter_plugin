#import "FlutterPlugin.h"

FlutterEventChannel *eventChannel;

@implementation FlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_plugin"
                                     binaryMessenger:[registrar messenger]];
    FlutterPlugin* instance = [[FlutterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    
    eventChannel = [FlutterEventChannel eventChannelWithName:@"flutter_plugin_event" binaryMessenger:[registrar messenger]];
    [eventChannel setStreamHandler:instance];
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
        
    }
    else if ([@"sayHello" isEqualToString:call.method]) {
        
        NSString *string = call.arguments[@"message"];
        NSLog(@"iOS:这是Dart层发送的数据:%@",string);
        result(@"Hello!");
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - FlutterStreamHandler代理
// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    self.eventSink = events;
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    //    if (events) {
    //        events(@"");//回调给flutter
    //    }
    ///可以在此做一些事
    //    NSLog(@"======%@", arguments);
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    ///可以在此做一些事
    self.eventSink = nil;
    return nil;
}


@end
