
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin {

  static const MethodChannel _channel = MethodChannel('flutter_plugin');

  static const EventChannel _eventChannel = EventChannel('flutter_plugin_event');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> sayHello(String message) async {
    final String? res = await _channel.invokeMethod('sayHello',{'message' :message});
    return res;
  }

  //监听 native event 数据流
  static void getAppDianl(onEvent, onError) {
    _eventChannel.receiveBroadcastStream().listen(onEvent, onError: onError);
  }
}
