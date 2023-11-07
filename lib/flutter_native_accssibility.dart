import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Define a platform channel
const MethodChannel _channel = MethodChannel('samples.flutter.dev');

// Define a method to start listening for text changes
Future<void> startTextChangeListener() async {
  try {
    var platformResult = await _channel.invokeMethod('startTextChangeListener');
    debugPrint("Data From Native :: $platformResult");
  } on PlatformException catch (e) {
    print('Error starting text listener: ${e.message}');
  }
}
