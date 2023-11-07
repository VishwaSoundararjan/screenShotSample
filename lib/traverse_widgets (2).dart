// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart';
//
// StreamController<String> controller = StreamController<String>();
// Stream<String> stream = controller.stream;
//
// Widget? w;
// // Map<dynamic, dynamic> info = {};
//
// // List<Map<dynamic, dynamic>> widgetData = []; //list: [RenderObject: left, top, width, height, widgetContext] -> 1
// List widgetContexts = []; // -> 2
// List dropDownContexts = [];
//
//
// List<Map<dynamic, dynamic>> widgetIdentifiers = [];
//
// List<String>? receivedList = [];
//
// int switchCount = 0;
// int checkBoxCount = 0;
// int radioCount = 0;
// int dropDownCount = 0;
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
//
//   late BuildContext buildContext;
//   static PointerRoute? previousGlobalEvent;
//
//   Future<List<Map<String,dynamic>>> traverseWidgetTree(BuildContext context) async {
//     buildContext = context;
//     screenName = context.runtimeType.toString();
//     widgetContexts.clear();
//     debugPrint("widgetContexts: $widgetContexts");
//
//     final widgets = <Widget>[];
//
//     ///gets current class name from the context and assign it to activityName
//     activityName = context.widget.runtimeType.toString();
//     screenName = activityName;
//     ///initializing [widgetList] List
//     widgetList = [];
//     _traverseWidget(context, widgets);
//     if (previousGlobalEvent != null) {
//       GestureBinding.instance.pointerRouter.removeGlobalRoute(previousGlobalEvent!);
//     }
//     // Add the new event.
//     GestureBinding.instance.pointerRouter.addGlobalRoute(globalEvent);
//     // Update the previous event reference.
//     previousGlobalEvent = globalEvent;
//     return widgetList;
//   }
//
//   void removeGestureBinding() {
//     //check remove GestureBindings
//   }
//
//   void globalEvent(PointerEvent event) {
//     try{
//       if (event is PointerDownEvent) {
//         final RenderObject? renderObject = buildContext.findRenderObject();
//         final RenderBox renderBox1 = buildContext.findRenderObject() as RenderBox;
//         final localPosition = renderBox1.globalToLocal(event.position);
//
//         //(2)
//         bool shouldBreak = false;
//         bool isDropDownButton = true;
//         if (isDropDownButton) {
//           for (var widget in widgetContexts) {
//             if (shouldBreak) return;
//             var currentRenderBox = widget.findRenderObject() as RenderBox?;
//             if (currentRenderBox != null) {
//               final position = currentRenderBox.localToGlobal(Offset.zero);
//               final size = currentRenderBox.size;
//               left = position.dx;
//               top = position.dy;
//               height = size.height;
//               width = size.width;
//               for (int i = left.toInt(); i <= left.toInt() + width.toInt(); i++) {
//                 for (int j = top.toInt(); j <=
//                     top.toInt() + height.toInt(); j++) {
//                   if (localPosition.dx.toInt() == i &&
//                       localPosition.dy.toInt() == j) {
//                     debugPrint("Clicked Widget(WL): $widget}");
//                     shouldBreak = true;
//                     // if(isDropDownButton) {
//                     //   for(var dropDownWidget in dropDownContexts) {
//                     //     debugPrint("DropDownWidget Values: ${dropDownWidget.widget.value}");
//                     //   }
//                     // }
//                     isDropDownButton = false;
//                     break;
//                   }
//                 }
//               }
//             }
//           }
//           if(isDropDownButton) {
//             for(var dropDownWidget in dropDownContexts) {
//               debugPrint("DropDownWidget Values: ${dropDownWidget.widget.value}");
//             }
//           }
//         }
//       }
//     } catch(e) {
//       debugPrint("Global Pointer Exception");
//     }
//   }
//
//   _traverseWidget(BuildContext context, List<Widget> widgets) {
//     currentWidget = context.widget;
//     var currentContext = context;
//     mapWidgetData = {};
//
//     if(context.widget is DropdownButton) {
//       debugPrint("DropDown Button found");
//
//       dropDownContexts.add(context);
//       widgetContexts.add(context);
//       var widget = currentWidget as DropdownButton;
//       List<DropdownMenuItem>? list = widget.items;
//       for(DropdownMenuItem item in list!) {
//         debugPrint("Item: ${item.value}");
//       }
//       debugPrint("DropDown Items: $list");
//
//       category = context.widget.runtimeType.toString();
//       var wid = context.widget as DropdownButton;
//       ///gets x,y position and height and width of current widget
//       getWidgetPosition(context);
//       ///assigning values to map[mapWidgetData]
//       mapWidgetData["activityName"] = activityName;
//       mapWidgetData["screenName"] = screenName;
//       mapWidgetData["category"] = category;
//       mapWidgetData["viewType"] = viewType;
//       mapWidgetData["subviews"] = subviews;
//       mapWidgetData["isShow"] = isShow;
//       mapWidgetData["id"] = id;
//       mapWidgetData["testId"] = 0;
//       mapWidgetData["currentID"] = currentID;
//       mapWidgetData["count"] = 0;
//       mapWidgetData["left"] = left;
//       mapWidgetData["top"] = top;
//       mapWidgetData["height"] = height;
//       mapWidgetData["width"] = width;
//       mapWidgetData["scrollX"] = scrollX;
//       mapWidgetData["scrollY"] = scrollY;
//       mapWidgetData["translationX"] = translationX;
//       mapWidgetData["translationY"] = translationY;
//
//       mapWidgetData["viewId"] = "${wid.runtimeType}${dropDownCount++}";
//       debugPrint("RadioBtnShort: ${wid.toStringShort()}");
//       widgetList.add(mapWidgetData);
//     }
//     if(context.widget is Radio) {
//       debugPrint("RADIO btn found");
//       widgetContexts.add(context);
//
//       category = context.widget.runtimeType.toString();
//       var wid = context.widget as Radio;
//       ///gets x,y position and height and width of current widget
//       getWidgetPosition(context);
//       ///assigning values to map[mapWidgetData]
//       mapWidgetData["activityName"] = activityName;
//       mapWidgetData["screenName"] = screenName;
//       mapWidgetData["category"] = category;
//       mapWidgetData["viewType"] = viewType;
//       mapWidgetData["subviews"] = subviews;
//       mapWidgetData["isShow"] = isShow;
//       mapWidgetData["id"] = id;
//       mapWidgetData["testId"] = 0;
//       mapWidgetData["currentID"] = currentID;
//       mapWidgetData["count"] = 0;
//       mapWidgetData["left"] = left;
//       mapWidgetData["top"] = top;
//       mapWidgetData["height"] = height;
//       mapWidgetData["width"] = width;
//       mapWidgetData["scrollX"] = scrollX;
//       mapWidgetData["scrollY"] = scrollY;
//       mapWidgetData["translationX"] = translationX;
//       mapWidgetData["translationY"] = translationY;
//
//       mapWidgetData["viewId"] = "${wid.runtimeType}${radioCount++}";
//       debugPrint("RadioBtnShort: ${wid.toStringShort()}");
//       widgetList.add(mapWidgetData);
//
//     }
//     if(context.widget is EditableText) {
//       var editableTextWidget = currentWidget as EditableText;
//       var wid = context.findAncestorWidgetOfExactType<TextField>();
//       TextEditingController? textEditingController = editableTextWidget.controller;
//       editableTextCallBack() {
//         debugPrint("EditableText listener called - ${textEditingController.text}");
//       }
//       textEditingController.addListener(editableTextCallBack);
//
//       debugPrint("TextFieldViewId: ${wid?.decoration?.labelText}");
//
//       category=currentWidget.runtimeType.toString();
//       ///gets x,y position and height and width of current widget
//       getWidgetPosition(context);
//       ///assigning values to map[mapWidgetData]
//       mapWidgetData["activityName"] = activityName;
//       mapWidgetData["screenName"] = screenName;
//       mapWidgetData["category"] = category;
//       mapWidgetData["viewType"] = viewType;
//       mapWidgetData["subviews"] = subviews;
//       mapWidgetData["isShow"] = isShow;
//       mapWidgetData["id"] = id;
//       mapWidgetData["testId"] = 0;
//       mapWidgetData["currentID"] = currentID;
//       mapWidgetData["count"] = 0;
//       mapWidgetData["left"] = left;
//       mapWidgetData["top"] = top;
//       mapWidgetData["height"] = height;
//       mapWidgetData["width"] = width;
//       mapWidgetData["scrollX"] = scrollX;
//       mapWidgetData["scrollY"] = scrollY;
//       mapWidgetData["translationX"] = translationX;
//       mapWidgetData["translationY"] = translationY;
//
//       //Get ViewId
//
//       mapWidgetData["viewId"] = "${wid?.decoration?.labelText}Tf";
//
//       widgetList.add(mapWidgetData);
//     }
//
//
//     switch (currentWidget.runtimeType) {
//       case GestureDetector:
//         var widget = currentWidget as GestureDetector;
//         RenderObject? renderObject = context.findRenderObject();
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
//         var editableText = context.findAncestorWidgetOfExactType<EditableText>();
//
//
//         if(textButton != null || elevatedButton != null || iconButton != null || inkWellButton != null || floatingActionButton != null || radio != null || checkBox != null || switchBtn != null || dropDownBtn != null || dropDownMenuItem != null) {
//
//         } else {
//           widgetContexts.add(currentContext);
//
//           category=currentWidget.runtimeType.toString();
//           var wid = currentWidget as GestureDetector;
//           ///gets x,y position and height and width of current widget
//           getWidgetPosition(context);
//           ///assigning values to map[mapWidgetData]
//           mapWidgetData["activityName"] = activityName;
//           mapWidgetData["screenName"] = screenName;
//           mapWidgetData["category"] = category;
//           mapWidgetData["viewType"] = viewType;
//           mapWidgetData["subviews"] = subviews;
//           mapWidgetData["isShow"] = isShow;
//           mapWidgetData["id"] = id;
//           mapWidgetData["testId"] = 0;
//           mapWidgetData["currentID"] = currentID;
//           mapWidgetData["count"] = 0;
//           mapWidgetData["left"] = left;
//           mapWidgetData["top"] = top;
//           mapWidgetData["height"] = height;
//           mapWidgetData["width"] = width;
//           mapWidgetData["scrollX"] = scrollX;
//           mapWidgetData["scrollY"] = scrollY;
//           mapWidgetData["translationX"] = translationX;
//           mapWidgetData["translationY"] = translationY;
//
//           if(wid.child is Text) {
//             var text = wid.child as Text;
//             debugPrint("InkWellText: ${text.data}");
//             mapWidgetData["viewId"] = "${text.data}GBtn";
//           }
//           ///assigning [mapWidgetData] Map to [widgetList] List
//           widgetList.add(mapWidgetData);
//
//         }
//         break;
//
//
//       case ElevatedButton:
//         widgetContexts.add(context);
//         category=currentWidget.runtimeType.toString();
//         var wid = currentWidget as ElevatedButton;
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//
//         if(wid.child is Text) {
//           var text = wid.child as Text;
//           debugPrint("EL TEXT: ${text.data.hashCode}");
//           mapWidgetData["viewId"] = "${text.data}EBtn";
//         }
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//         break;
//
//       case TextButton:
//         widgetContexts.add(context);
//
//         category=currentWidget.runtimeType.toString();
//         var wid = currentWidget as TextButton;
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//
//         if(wid.child is Text) {
//           var text = wid.child as Text;
//           debugPrint("TEXTBTNTEXT: ${text.data}");
//           mapWidgetData["viewId"] = "${text.data}TBtn";
//         }
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//         break;
//
//       case IconButton:
//         widgetContexts.add(context);
//
//         category=currentWidget.runtimeType.toString();
//         var wid = currentWidget as IconButton;
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//         var icon = wid.icon as Icon;
//         debugPrint("ICON DATA: $icon");
//         IconData iconData = icon.icon as IconData;
//         String iconName = iconData.toString();
//         debugPrint('Icon Name: $iconName');
//
//         mapWidgetData["viewId"] = "${iconName}IBtn";
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//         break;
//
//       case FloatingActionButton:
//         widgetContexts.add(context);
//
//         category=currentWidget.runtimeType.toString();
//         var wid = currentWidget as FloatingActionButton;
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//         if(wid.child is Text) {
//           var text = wid.child as Text;
//           debugPrint("FABTEXT: ${text.data}");
//           mapWidgetData["viewId"] = "${text.data}FBtn";
//         } else if(wid.child is Icon) {
//           var icon = wid.child as Icon;
//           debugPrint("ICON DATA: $icon");
//           IconData iconData = icon.icon as IconData;
//           String iconName = iconData.toString();
//           debugPrint('Icon Name: $iconName');
//           mapWidgetData["viewId"] = "${iconName}FBtn";
//         } else if(wid.child is AssetImage) {
//           AssetImage img = wid.child as AssetImage;
//           mapWidgetData["viewId"] = "${img.assetName}FBtn";
//         }
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//
//         break;
//
//       case Switch:
//         widgetContexts.add(context);
//
//         category=currentWidget.runtimeType.toString();
//         var wid = currentWidget as Switch;
//         count++;
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//         mapWidgetData["viewId"] = "${wid.toStringShort()}${switchCount++}";
//         // debugPrint("SwitchViewId: ${wid.toStringShort()}${switchCount++}");
//         debugPrint("SwitchViewId: ${mapWidgetData['viewId']}");
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//         break;
//
//       case Checkbox:
//         widgetContexts.add(context);
//         var wid = currentWidget as Checkbox;
//         category=currentWidget.runtimeType.toString();
//         ///gets x,y position and height and width of current widget
//         getWidgetPosition(context);
//         ///assigning values to map[mapWidgetData]
//         mapWidgetData["activityName"] = activityName;
//         mapWidgetData["screenName"] = screenName;
//         mapWidgetData["category"] = category;
//         mapWidgetData["viewType"] = viewType;
//         mapWidgetData["subviews"] = subviews;
//         mapWidgetData["isShow"] = isShow;
//         mapWidgetData["id"] = id;
//         mapWidgetData["testId"] = 0;
//         mapWidgetData["currentID"] = currentID;
//         mapWidgetData["count"] = 0;
//         mapWidgetData["left"] = left;
//         mapWidgetData["top"] = top;
//         mapWidgetData["height"] = height;
//         mapWidgetData["width"] = width;
//         mapWidgetData["scrollX"] = scrollX;
//         mapWidgetData["scrollY"] = scrollY;
//         mapWidgetData["translationX"] = translationX;
//         mapWidgetData["translationY"] = translationY;
//
//         mapWidgetData["viewId"] = "${wid.runtimeType}${checkBoxCount++}";
//
//         // debugPrint("CheckboxViewId: ${wid.toStringShort()}${checkBoxCount++}");
//         debugPrint("CheckboxViewId: ${mapWidgetData['viewId']}");
//         ///assigning [mapWidgetData] Map to [widgetList] List
//         widgetList.add(mapWidgetData);
//
//         break;
//
//       case InkWell:
//         var elevatedButton = context.findAncestorWidgetOfExactType<ElevatedButton>();
//         var dropDownButton = context.findAncestorWidgetOfExactType<DropdownButton>();
//         var floatingActionButton = context.findAncestorWidgetOfExactType<FloatingActionButton>();
//         var gestureDetectorButton = context.findAncestorWidgetOfExactType<GestureDetector>();
//         if(elevatedButton != null || dropDownButton != null || floatingActionButton != null) {
//           //InkWell of type elevatedButton or dropDownButton or floatingActionButton
//         } else if(currentWidget is GestureDetector) {
//           //InkWell of type gestureDetectorButton
//         } else {
//           widgetContexts.add(context);
//
//           category=currentWidget.runtimeType.toString();
//           var wid = currentWidget as InkWell;
//           ///gets x,y position and height and width of current widget
//           getWidgetPosition(context);
//           ///assigning values to map[mapWidgetData]
//           mapWidgetData["activityName"] = activityName;
//           mapWidgetData["screenName"] = screenName;
//           mapWidgetData["category"] = category;
//           mapWidgetData["viewType"] = viewType;
//           mapWidgetData["subviews"] = subviews;
//           mapWidgetData["isShow"] = isShow;
//           mapWidgetData["id"] = id;
//           mapWidgetData["testId"] = 0;
//           mapWidgetData["currentID"] = currentID;
//           mapWidgetData["count"] = 0;
//           mapWidgetData["left"] = left;
//           mapWidgetData["top"] = top;
//           mapWidgetData["height"] = height;
//           mapWidgetData["width"] = width;
//           mapWidgetData["scrollX"] = scrollX;
//           mapWidgetData["scrollY"] = scrollY;
//           mapWidgetData["translationX"] = translationX;
//           mapWidgetData["translationY"] = translationY;
//
//           if(wid.child is Text) {
//             var text = wid.child as Text;
//             debugPrint("InkWellText: ${text.data}");
//             mapWidgetData["viewId"] = "${text.data}IwBtn";
//           }
//
//           ///assigning [mapWidgetData] Map to [widgetList] List
//           widgetList.add(mapWidgetData);
//
//         }
//         break;
//
//       case Text:
//         var textWidget = currentWidget as Text;
//         break;
//
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
