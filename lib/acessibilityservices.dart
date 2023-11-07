import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_accessibility_service/accessibility_event.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';


class MyAccessibility extends StatefulWidget {
  const MyAccessibility({Key? key}) : super(key: key);

  @override
  State<MyAccessibility> createState() => _MyAccessibility();
}

Map<dynamic,dynamic> dataMap = {};
class _MyAccessibility extends State<MyAccessibility> {
  StreamSubscription<AccessibilityEvent>? _subscription;
  List<AccessibilityEvent?> events = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
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
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text(events[index]!.packageName!),
                    subtitle: Text(events[index]!.capturedText ?? ""),
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                print("button-1 pressed");
                //traverseWidgets(context);
              }, child: Text('Button-1')),

            ],
          ),
        ),
      ),
    );
  }
}
