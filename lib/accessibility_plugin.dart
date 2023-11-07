import 'dart:async';
import 'dart:developer';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/accessibility_event.dart';
import 'package:flutter_accessibility_service/constants.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';
import 'package:screenshotsample/screenTracking.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';

import 'main.dart';

class AccessibilityPlugin extends StatefulWidget {
  const AccessibilityPlugin({Key? key}) : super(key: key);

  @override
  State<AccessibilityPlugin> createState() => _AccessibilityPluginState();
}

class _AccessibilityPluginState extends State<AccessibilityPlugin>  with WidgetsBindingObserver {
  StreamSubscription<AccessibilityEvent>? _subscription;
  List<AccessibilityEvent?> events = [];

  var keys = <String>{};
  var _keyCounter = 0;
  var keyTxt = "Txt";
  var btnTxt = "Btn";

  // Key _widgetKey = ValueKey<int>(1);

  // void assignNewKey() {
  //   setState(() {
  //     _keyCounter++;
  //     // _widgetKey = ValueKey<int>(_keyCounter);
  //   });
  // }

  // final ValueKey buttonKey = const ValueKey<int>(123);
  // final GlobalKey<_AccessibilityPluginState> buttonKey = GlobalKey<_AccessibilityPluginState>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
    // Write your code
      case AppLifecycleState.resumed:
        print("AppLifecycleState: RESUMED");
        if (_subscription?.isPaused ?? false) {
          _subscription?.resume();
          return;
        }
        _subscription = FlutterAccessibilityService.accessStream
            .listen((event) {
          if (event.packageName == "com.example.screenshotsample") {
            // Only capture events from your Flutter app
            log("$event Captured");
            log('Event Type: ${event.eventType}');


            setState(() {
              events.add(event);
            });
          }
          // log("$event Captured");
          // setState(() {
          //   events.add(event);
          // });
        });
        break;
      case AppLifecycleState.inactive:
        print("AppLifecycleState: INACTIVE");
        _subscription?.cancel();
        break;
      case AppLifecycleState.paused:
        print("AppLifecycleState: PAUSED");
        break;
      case AppLifecycleState.detached:
        print("AppLifecycleState: DETACHED");
        break;
      // case AppLifecycleState.hidden:
      //   print("AppLifecycleState: HIDDEN");
    }
  }

  void btnClick() {
    print("Button clicked");
  }

  void traverseWidgetTree(BuildContext element) {
    final widgetData = <String, dynamic>{};
    if (element.widget is Text) {
      final textWidget = element.widget as Text;
      widgetData['data'] = textWidget.data;
    } else if (element.widget is ElevatedButton) {
      final elevatedButtonWidget = element.widget as ElevatedButton;
      // assignNewKey();
      // Future.delayed(Duration(seconds: 2), assignNewKey);
      debugPrint('Widget Type: ElevatedButton');
    } else if (element.widget is TextField ) {
      final currentWidget = element.widget as TextField;
      debugPrint('Widget Type: TextField');
    }

    element.visitChildElements((child) {
      traverseWidgetTree(child);
    });
  }
  void takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    debugPrint('Screenshot taken, path: $path');
    methodChannel.invokeMethod('passScreenshotData',path);
  }

  updateViewJson() async {
    List<Map<String,dynamic>> fieldTrackingData = await ScreenTracking().traverseWidgetTree(context);//updateViewsJson
    methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
    //print("$fieldTrackingData");
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   traverseWidgetTree(context);
    // });
     const oneSec = Duration(seconds: 2);
     Timer.periodic(oneSec, (Timer timer) async {
    // This statement will be printed after every one second
       takeScreenshotMethod();
       updateViewJson();
     });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
              ElevatedButton(
                  key: const ValueKey<int>(1),
                  onPressed: () {},
                  child: const Text("click")
              ),
              TextButton(
                // key: _widgetKey,
                onPressed: () {
                  // Key? buttonKey = widget.key;
                  // print("ValueKey value: $buttonKey");

                },
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Flat Button',
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await FlutterAccessibilityService
                            .requestAccessibilityPermission();
                      },
                      child: const Text("Request Permission"),
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () async {
                        final bool res = await FlutterAccessibilityService
                            .isAccessibilityPermissionEnabled();
                        log("Is enabled: $res");
                      },
                      child: const Text("Check Permission"),
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {
                        if (_subscription?.isPaused ?? false) {
                          _subscription?.resume();
                          return;
                        }
                        _subscription = FlutterAccessibilityService.accessStream
                            .listen((event) {
                          log("$event");
                          setState(() {
                            events.add(event);
                          });
                        });
                      },
                      child: const Text("Start Stream"),
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {
                        _subscription?.cancel();
                      },
                      child: const Text("Stop Stream"),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: events.length,
              //     itemBuilder: (_, index) => ListTile(
              //       title: Text(events[index]!.packageName!),
              //       subtitle: Text(events[index]!.nodesText.toString() ?? ""),
              //     ),
              //   ),
              // )
              // Expanded(
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: events.length,
              //     itemBuilder: (_, index) {
              //       final event = events[index];
              //
              //       // Check if nodesText is not empty
              //       if (event?.nodesText.toString() != "[]" ) {
              //         return ListTile(
              //           title: Text(event?.packageName ?? ""),
              //           subtitle: Text(event!.nodesText.toString()),
              //         );
              //       } else {
              //         // Return an empty Container if nodesText is empty
              //         return Container();
              //       }
              //     },
              //   ),
              // )

            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonExt extends ElevatedButton {
  ElevatedButtonExt({super.key, required super.onPressed, required super.child});
  @override
  var keyId = 0;
}