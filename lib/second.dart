import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'main.dart';
import 'dart:io';
import 'screenTracking.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {

  void takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    methodChannel.invokeMethod('passScreenshotData',path);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const oneSec = Duration(seconds: 2);
    Timer.periodic(oneSec, (Timer timer) async {
      List<Map<String,dynamic>> fieldTrackingData =  await ScreenTracking().traverseWidgetTree(this.context);//updateViewsJson
      methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
      print("Send Image");  // This statement will be printed after every one second
      takeScreenshotMethod();
    });
    return const Scaffold(
      body: Center(
        child: Text("Second Page")
      ),
    );
  }
}
