// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:observable/observable.dart';
// import 'package:provider/provider.dart';
// import 'package:screenshotsample/listener1.dart';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// // import 'package:refluttersdk/refluttersdk_method_channel.dart';
// import 'dart:io';
// import 'package:screenshotsample/main.dart';
//
//
//
// StreamController<String> controller = StreamController<String>();
// Stream<String> stream = controller.stream;
// var customNotifier = CustomChangeNotifier();
//
// Widget? w;
// // Map<dynamic, dynamic> info = {};
//
// // List<Map<dynamic, dynamic>> widgetData = []; //list: [RenderObject: left, top, width, height, widgetContext] -> 1
// List widgetContexts = []; // -> 2
// List dropDownContexts = [];
//
// List<Map<dynamic, dynamic>> widgetWithIds = [];
//
// List<String>? receivedList = [];
//
//
// class TraverseClass extends NavigatorObserver{
//
//   late String activityName;
//   late String screenName;
//   late String category;
//   late var data;
//   late var className;
//   late Map<String, dynamic> mapWidgetData;
//   late List<Map<String, dynamic>> widgetList;
//
//
//   late Widget currentWidget;
//
//   late List<Widget> widgetLists = [];
//
//   int id = 0;
//   int count = 0;
//   int testId = 0;
//   String viewId = "";
//   String currentID = "";
//   double left = 0;
//   double top = 0;
//   double height = 0;
//   double width = 0;
//   int scrollX = 0;
//   int scrollY = 0;
//   int translationX = 0;
//   int translationY = 0;
//   String viewType = 'Others';
//   String subviews = '';
//   bool isShow = true;
//
//   void check(RenderObject r) {
//     r.visitChildren((child) {
//       debugPrint("CHILD: $child");
//       check(child);
//     });
//   }
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route is MaterialPageRoute) {
//       debugPrint('Page pushed: ${route.settings.name}');
//     }
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPop(route, previousRoute);
//     if (route is MaterialPageRoute) {
//       debugPrint('Page popped: ${route.settings.name}');
//     }
//   }
//
//   Widget? findWidgetAtPosition(Offset localPosition, BuildContext context) {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//
//     // Perform hit testing
//     final result = BoxHitTestResult();
//     renderBox.hitTest(result, position: localPosition);
//
//     // debugPrint("localPosition: $localPosition");
//
//     for (final entry in result.path) {
//       if (entry.target is RenderBox) {
//         final RenderBox targetRenderBox = entry.target as RenderBox;
//         Widget? widget = findWidgetFromRenderBox(targetRenderBox, context);
//
//         if (widget != null) {
//           return widget;
//         }
//       }
//     }
//
//     return null;
//   }
//
//   String generateRandomString(int length) {
//     const String characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
//     final random = Random();
//     final buffer = StringBuffer();
//
//     for (int i = 0; i < length; i++) {
//       buffer.write(characters[random.nextInt(characters.length)]);
//     }
//
//     return buffer.toString();
//   }
//
//   Widget? findWidgetFromRenderBox(RenderBox targetRenderBox, BuildContext context) {
//     Element? element;
//
//     BuildContext? currentContext = context;
//
//
//     while (currentContext != null) {
//       if (currentContext.findRenderObject() == targetRenderBox) {
//         element = currentContext as Element;
//         break;
//       }
//
//       final widget = currentContext.widget;
//
//       if (widget is IconButton) {
//         debugPrint("Element is MaterialApp || Scaffold");
//         break; // You can adjust this to match your widget hierarchy
//       }
//
//       currentContext = currentContext.findAncestorWidgetOfExactType<IconButton>() as BuildContext?;
//     }
//
//     return element?.widget;
//   }
//
//   void storeListInPageStorage(BuildContext context, String screenName) {
//     final PageStorageBucket bucket = PageStorage.of(context);
//     // Store your data list in PageStorage using a unique key
//     widgetWithIds.clear();
//     bucket.writeState(context, widgetWithIds, identifier: screenName);
//
//     List<Map<dynamic,dynamic>> getData = bucket.readState(context, identifier: screenName);
//     debugPrint("Read Data AT a time: $getData");
//   }
//
//   // List<Map<dynamic,dynamic>>? retrieveListFromPageStorage(BuildContext context, String screenName) {
//   //   // receivedList?.clear();
//   //   final PageStorageBucket bucket = PageStorage.of(context);
//   //   final List<Map<dynamic,dynamic>>? myDataList = bucket.readState(context, identifier: screenName);
//   //   debugPrint("MYDATALIST: $myDataList");
//   //   // receivedList = myDataList;
//   //   return myDataList;
//   // }
//
//   Future<List<Map<String,dynamic>>> traverseWidgetTree(BuildContext context) async {
//
//     screenName = context.widget.runtimeType.toString();
//     widgetContexts.clear();
//     debugPrint("widgetContexts: $widgetContexts");
//
//     final widgets = <Widget>[];
//     final dialogManager = DialogNavigationManager();
//     dialogManager.dialogStream.listen((_) {
//       // Handle dialog event here.
//       debugPrint('Dialog shown.');
//     });
//
//
//
//     GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
//
//       if(event is PointerDownEvent) {
//
//         final RenderObject? renderObject = context.findRenderObject();
//         final RenderBox renderBox1 = context.findRenderObject() as RenderBox;
//         final localPosition = renderBox1.globalToLocal(event.position);
//
//
//
//         //(2)
//         bool shouldBreak = false;
//         bool isDropDownButton = true;
//         if(isDropDownButton) {
//           for(var widget in widgetContexts) {
//             if(shouldBreak) return;
//             var currentRenderBox =  widget.findRenderObject() as RenderBox?;
//             if(currentRenderBox != null) {
//               final position = currentRenderBox.localToGlobal(Offset.zero);
//               final size = currentRenderBox.size;
//               left = position.dx;
//               top = position.dy;
//               height = size.height;
//               width = size.width;
//               for (int i = left.toInt(); i <= left.toInt() + width.toInt(); i++) {
//                 for (int j = top.toInt(); j <= top.toInt() + height.toInt(); j++) {
//                   if (localPosition.dx.toInt() == i && localPosition.dy.toInt() == j) {
//                     debugPrint("Clicked Widget(WL): $widget}");
//                     shouldBreak = true;
//                     isDropDownButton = false;
//                     break;
//                   }
//                 }
//               }
//             }
//           }
//           if(isDropDownButton) {
//             for(var dropDownWidget in dropDownContexts) {
//                 debugPrint("DropDownWidget Values: ${dropDownWidget.widget.value}");
//             }
//           }
//         }
//
//
//         // debugPrint("event.buttons: ${event.buttons}");
//         // debugPrint("event.viewId: ${event.viewId}");
//         // debugPrint("event.position: ${event.position}");
//         // debugPrint("event.transform: ${event.transform}");
//         // debugPrint("event.timeStamp: ${event.timeStamp}");
//         //
//         // debugPrint("event.pointer: ${event.pointer}");
//         // debugPrint("event.embedderId: ${event.embedderId}");
//         // debugPrint("event.localPosition: ${event.localPosition}");
//         // debugPrint("event.device: ${event.device}");
//         // debugPrint("event.delta: ${event.delta}");
//         //
//         // debugPrint("event.transform: ${event.transform}");
//         // debugPrint("event.distance: ${event.distance}");
//         // debugPrint("event.distanceMax: ${event.distanceMax}");
//         // debugPrint("event.distanceMin: ${event.distanceMin}");
//         // debugPrint("event.down: ${event.down}");
//         //
//         // debugPrint("event.kind: ${event.kind}");
//         // debugPrint("event.localDelta: ${event.localDelta}");
//         // debugPrint("event.obscured: ${event.obscured}");
//         // debugPrint("event.orientation: ${event.orientation}");
//         // debugPrint("event.original: ${event.original}");
//         //
//         // debugPrint("event.platformData: ${event.platformData}");
//         // debugPrint("event.pressure: ${event.pressure}");
//         // debugPrint("event.pressureMax: ${event.pressureMax}");
//         // debugPrint("event.pressureMin: ${event.pressureMin}");
//         // debugPrint("event.radiusMajor: ${event.radiusMajor}");
//         //
//         // debugPrint("event.radiusMinor: ${event.radiusMinor}");
//         // debugPrint("event.radiusMax: ${event.radiusMax}");
//         // debugPrint("event.radiusMin: ${event.radiusMin}");
//         // debugPrint("event.size: ${event.size}");
//         // debugPrint("event.synthesized: ${event.synthesized}");
//         // debugPrint("event.tilt: ${event.tilt}");
//
//
//       }
//     });
//     ///gets current class name from the context and assign it to activityName
//     activityName = context.widget.runtimeType.toString();
//     screenName = activityName;
//     ///initializing [widgetList] List
//     widgetList = [];
//     _traverseWidget(context, widgets);
//     // storeListInPageStorage(context, screenName);
//     return widgetList;
//   }
//
//
//
//   _traverseWidget(BuildContext context, List<Widget> widgets)  {
//     currentWidget = context.widget;
//     var currentContext = context;
//     mapWidgetData = {};
//
//     if(context.widget is DropdownButton) {
//       debugPrint("DropDown Button found");
//       dropDownContexts.add(context);
//       widgetContexts.add(context);
//       var widget = currentWidget as DropdownButton;
//       List<DropdownMenuItem>? list = widget.items;
//       for(DropdownMenuItem item in list!) {
//         debugPrint("Item: ${item.value}");
//       }
//       debugPrint("DropDown Items: $list");
//
//     }
//     if(context.widget is Radio) {
//       debugPrint("RADIO btn found");
//       widgetContexts.add(context);
//     }
//     if(context.widget is DropdownMenuItem) {
//       // dropDownContexts.add(context);
//     }
//
//
//     switch (currentWidget.runtimeType) {
//       case GestureDetector:
//         var widget = currentWidget as GestureDetector;
//         RenderObject? renderObject = context.findRenderObject();
//         count = 0;
//
//         var elevatedButton = context.findAncestorWidgetOfExactType<ElevatedButton>();
//         var textButton = context.findAncestorWidgetOfExactType<TextButton>();
//         var iconButton = context.findAncestorWidgetOfExactType<IconButton>();
//         var inkWellButton = context.findAncestorWidgetOfExactType<InkWell>();
//         var floatingActionButton = context.findAncestorWidgetOfExactType<FloatingActionButton>();
//         var radio = context.findAncestorWidgetOfExactType<Radio>();
//         var checkBox = context.findAncestorWidgetOfExactType<Checkbox>();
//         var switchBtn = context.findAncestorWidgetOfExactType<Switch>();
//         var dropDownBtn = context.findAncestorWidgetOfExactType<DropdownButton>();
//         var dropDownMenuItem = context.findAncestorWidgetOfExactType<DropdownMenuItem>();
//
//
//         if(textButton != null || elevatedButton != null || iconButton != null || inkWellButton != null || floatingActionButton != null || radio != null || checkBox != null || switchBtn != null || dropDownBtn != null || dropDownMenuItem != null) {
//
//         } else {
//           widgetContexts.add(currentContext);
//           //withID - check
//           var id = generateRandomString(5);
//           Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//           widgetWithIds.add(map);
//         }
//         break;
//
//
//       case ElevatedButton:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case TextButton:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case IconButton:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case FloatingActionButton:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case Switch:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case FocusableActionDetector:
//         var cBtn = context.findAncestorWidgetOfExactType<Checkbox>();
//         var sBtn = context.findAncestorWidgetOfExactType<Switch>();
//
//         if(cBtn == null && sBtn == null) {
//           widgetContexts.add(context);
//           //withID - check
//           var id = generateRandomString(5);
//           Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//           widgetWithIds.add(map);
//         }
//         break;
//
//       case Checkbox:
//         widgetContexts.add(context);
//         //withID - check
//         var id = generateRandomString(5);
//         Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//         widgetWithIds.add(map);
//         break;
//
//       case InkWell:
//         var elevatedButton = context.findAncestorWidgetOfExactType<ElevatedButton>();
//         var dropDownButton = context.findAncestorWidgetOfExactType<DropdownButton>();
//         var floatingActionButton = context.findAncestorWidgetOfExactType<FloatingActionButton>();
//         if(elevatedButton != null || dropDownButton != null || floatingActionButton != null) {
//           //InkWell of type elevatedButton or dropDownButton or floatingActionButton
//         } else {
//           widgetContexts.add(context);
//           //withID - check
//           var id = generateRandomString(5);
//           Map<dynamic, dynamic> map = {'context': currentContext, 'id': id};
//           widgetWithIds.add(map);
//         }
//         break;
//       case Text:
//         var textWidget = currentWidget as Text;
//         var menuItem = context.findAncestorWidgetOfExactType<IndexedStack>();
//         if(menuItem != null) {
//           debugPrint("IndexStack TRUE");
//           widgetContexts.add(context);
//         }
//         break;
//       default:
//         {
//           //print("WidgetType does not match");
//         }
//         break;
//     }
//     ///reassigning [viewId] and [currentID] to default
//     viewId="";
//     currentID="";
//     ///for recursive calling of [_traverseWidget] method for traversing child or children of widgets
//     final element = context as Element;
//     element.visitChildren((child) {
//       _traverseWidget(child, widgets);
//     });
//   }
//
//
//   void getWidgetPosition(currentContext) async {
//     final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
//     if (renderBox != null) {
//       final position = renderBox.localToGlobal(Offset.zero);
//       final size = renderBox.size;
//       left=position.dx;
//       top=position.dy;
//       height=size.height;
//       width=size.width;
//       // RenderRepaintBoundary boundary =currentContext.findRenderObject() as RenderRepaintBoundary;
//       // ui.Image image = await boundary.toImage();
//       // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       // if (byteData != null) {
//       //   Uint8List pngBytes = byteData.buffer.asUint8List();
//       // }
//     }
//   }
//
//
//
//   Map getWidgetPositions(currentContext) {
//     final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
//     if (renderBox != null) {
//       final position = renderBox.localToGlobal(Offset.zero);
//       final size = renderBox.size;
//       left=position.dx;
//       top=position.dy;
//       height=size.height;
//       width=size.width;
//
//       Map<dynamic, dynamic> positionValues = {'left' : left, 'top': top, 'height': height, 'width': width};
//       return positionValues;
//     }
//     return {};
//   }
//
//   void findWidget(BuildContext context) {
//     if(context is TextButton) {
//       debugPrint("TextButton clicked");
//     } else {
//       debugPrint("Other than TextButton clicked");
//     }
//   }
//
// }
