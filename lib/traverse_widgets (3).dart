import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:provider/provider.dart';
import 'main.dart';


StreamController<String> controller = StreamController<String>();
Stream<String> stream = controller.stream;

Widget? w;

List<Map<String, dynamic>> widgetContexts = []; // -> 2

List dropDownContexts = [];
List<Map<String, dynamic>> seperatedList = [];
List finalFieldTrackData = [];

List<Map<dynamic, dynamic>> widgetIdentifiers = [];
List<Map<dynamic, dynamic>> finalFieldTrackList = [];
List<String>? receivedList = [];

int switchCount = 0;
int checkBoxCount = 0;
int radioCount = 0;
int dropDownCount = 0;

List dataModels = [
  // {
  //   'screenName': 'LearningDemo',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'TestEBtn',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'UserForm',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'Page2',
  //   'eventName': 'Button Tap event',
  //   'viewType': 'Value',
  //   'identifier': 'ClickEBtn',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'UserForm',
  //   'campaignId': 71780,
  // },
  // {
  //   'screenName': 'LearningDemo',
  //   'eventName': 'TextField Tap event',
  //   'viewType': 'Value',
  //   'identifier': 'PasswordTf',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'UserForm',
  //   'campaignId': 71780,
  // },
  {
    'screenName': 'DashBoardScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'https://vcdn1-giaitri.vnecdn.net/2015/04/23/1-4854-1429761605.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=Bp8MxcmkYfVaR4Hvlg9qAgNImg',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'BodyPage',
    'campaignId': 71627,
  },
  {
    'screenName': 'DashBoardScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'https://cafefcdn.com/thumb_w/650/2019/6/4/5069g-3x2-forever-in-florals-768x512-1559636365541203324963-crop-15596363709051973797845.jpgNImg',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'BodyPage',
    'campaignId': 71627,
  },

  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'Summer Wear',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'SaleTxt',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'View allTxt',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': '(10)Txt',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'Vasant ApparelTxt',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'BodyPage',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'TanishTxt',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  // {
  //   'screenName': 'DashBoardScreen',
  //   'eventName': 'Changing text event',
  //   'viewType': 'Value',
  //   'identifier': 'IconData(U+0E5F9)Icon',
  //   'captureType': 'Value',
  //   'markAsGoal': false,
  //   'mainScreenName': '',
  //   'activityName': 'BodyPage',
  //   'campaignId': 71627,
  // },
  {
    'screenName': 'DetailProductScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'ADD TO CARTEBtn',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'DetailProductScreen',
    'campaignId': 71627,
  },
  {
    'screenName': 'LoginScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'EmailTf',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'UserForm',
    'campaignId': 71627,
  },
  {
    'screenName': 'LoginScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'Checkbox0',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'UserForm',
    'campaignId': 71627,
  },
  {
    'screenName': 'LoginScreen',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': 'LOGINBtn',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'UserForm',
    'campaignId': 71627,
  },
];

class TraverseClass extends NavigatorObserver{

  late String activityName;
  late String screenName;
  late String category;
  late var data;
  late var className;
  late Map<String, dynamic> mapWidgetData;
  late List<Map<String, dynamic>> widgetList = [];
  late List<BuildContext> inkWellContext = [];
  late List<BuildContext> textFieldContext = [];
  String prevTextFieldData="";

  late Widget currentWidget;

  late List<Widget> widgetLists = [];

  int id = 0;
  int count = 0;
  int testId = 0;
  String viewId = "";
  String currentID = "";
  double left = 0;
  double top = 0;
  double height = 0;
  double width = 0;
  int scrollX = 0;
  int scrollY = 0;
  int translationX = 0;
  int translationY = 0;
  String viewType = 'Value';
  String subviews = "[-2032458054, -1732272221, 1263557818, 182189504, -250970052, 2035050500, -1288751591]";
  bool isShow = true;
  static Timer? _timer;
  static initiate(BuildContext context){
     TraverseClass traverseClass = TraverseClass();
     if (_timer != null && _timer!.isActive) {
       _timer!.cancel();
     }

     const oneSec = Duration(seconds: 2);
     _timer = Timer.periodic(oneSec, (Timer timer) async {
       traverseClass._takeScreenshotMethod();
       traverseClass._updateViewJson(traverseClass,context);
       if(!context.mounted){
         _timer?.cancel();
       }
     });
   }

  void _takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    //debugPrint('Screenshot taken, path: $path');
    methodChannel.invokeMethod('passScreenshotData',path);
  }

  _updateViewJson(TraverseClass traverseClass,BuildContext context) async {
    List<Map<String,dynamic>> fieldTrackingData = await traverseClass.traverseWidgetTree(context);//updateViewsJson
    methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
    //print("$fieldTrackingData");
  }



  Widget? findWidgetAtPosition(Offset localPosition, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    // Perform hit testing
    final result = BoxHitTestResult();
    renderBox.hitTest(result, position: localPosition);

    // debugPrint("localPosition: $localPosition");

    for (final entry in result.path) {
      if (entry.target is RenderBox) {
        final RenderBox targetRenderBox = entry.target as RenderBox;
        Widget? widget = findWidgetFromRenderBox(targetRenderBox, context);

        if (widget != null) {
          return widget;
        }
      }
    }

    return null;
  }

  String generateRandomString(int length) {
    const String characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random();
    final buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      buffer.write(characters[random.nextInt(characters.length)]);
    }
    return buffer.toString();
  }

  Widget? findWidgetFromRenderBox(RenderBox targetRenderBox, BuildContext context) {
    Element? element;

    BuildContext? currentContext = context;


    while (currentContext != null) {
      if (currentContext.findRenderObject() == targetRenderBox) {
        element = currentContext as Element;
        break;
      }

      final widget = currentContext.widget;

      if (widget is IconButton) {
        debugPrint("Element is MaterialApp || Scaffold");
        break; // You can adjust this to match your widget hierarchy
      }

      currentContext = currentContext.findAncestorWidgetOfExactType<IconButton>() as BuildContext?;
    }

    return element?.widget;
  }


  late BuildContext buildContext;
  static PointerRoute? previousGlobalEvent;
  late BuildContext contextForStatusbar;
  Future<List<Map<String,dynamic>>> traverseWidgetTree(BuildContext context) async {
    contextForStatusbar = context;
    widgetList.clear();
    buildContext = context;
    screenName = context.runtimeType.toString();
    widgetContexts.clear();
    checkBoxCount =0;
    final widgets = <Widget>[];

    ///gets current class name from the context and assign it to activityName
    activityName = context.widget.runtimeType.toString();
    screenName = activityName;
    ///initializing [widgetList] List
    widgetList = [];
    if (previousGlobalEvent != null) {
      GestureBinding.instance.pointerRouter.removeGlobalRoute(previousGlobalEvent!);
    }
    // Add the new event.
    GestureBinding.instance.pointerRouter.addGlobalRoute(globalEvent);
    // Update the previous event reference.
    previousGlobalEvent = globalEvent;
    _traverseWidget(context, widgets);

    if(dataModels!=null){
      await seperateList();
    }

    //debugPrint("final LIST: $widgetList");

    return widgetList;
  }

  Future<void> seperateList() async {
    seperatedList.clear();
    for(var data in dataModels){
      var tID = data["identifier"];
      for(var mapData in widgetContexts){
        for(var keys in mapData.keys){
          var viewId = keys;
          if(viewId == tID){
            seperatedList.add(mapData);
            // debugPrint("Seperate List: $seperatedList");
          }
        }
      }
    }
  }
  String extractFirstWord(String input) {
    // Remove any leading or trailing spaces and special characters
    input = input.trim().replaceAll(RegExp(r"[^\w\s]"), "");

    // Split the string into words
    List<String> words = input.split(RegExp(r"\s+"));

    // Take the first word (if any)
    if (words.isNotEmpty) {
      return words.first;
    }
    // If no words are found, return an empty string or handle it as needed
    return "";
  }
  getKey(BuildContext context){
    ///to get key for textfield

    var wid = context.findAncestorWidgetOfExactType<TextField>();
      var key ="${wid?.decoration!.labelText ?? (wid?.decoration?.hintText ?? 'noHint')}Tf";
    return key;

  }
  void globalEvent(PointerEvent event) {
    try{
      if (event is PointerDownEvent) {
        final RenderObject? renderObject = buildContext.findRenderObject();
        final RenderBox renderBox1 = buildContext.findRenderObject() as RenderBox;
        final localPosition = renderBox1.globalToLocal(event.position);

        finalFieldTrackData.clear();

        //(2)
        bool shouldBreak = false;
        bool isDropDownButton = true;
        for(var widget in seperatedList) {
          for(var value in widget.values) {
            var widContext = value.toString();
            final match1 = RegExp(r'(\w+)(?:\(dependencies|-\[)').firstMatch(widContext);
            if(match1?.group(1) != "EditableText" || widContext == "InkWell") {
              var currentRenderBox = value.findRenderObject() as RenderBox?;
              if (currentRenderBox != null) {
                final position = currentRenderBox.localToGlobal(Offset.zero);
                final size = currentRenderBox.size;
                left = position.dx;
                top = position.dy;
                height = size.height;
                width = size.width;
                for (int i = left.toInt(); i <= left.toInt() + width.toInt(); i++) {
                  for (int j = top.toInt(); j <= top.toInt() + height.toInt(); j++) {
                    if (localPosition.dx.toInt() == i && localPosition.dy.toInt() == j) {
                      for(var data in widgetContexts) {
                        for(var widgetContext in data.entries) {
                          if(widgetContext.value == value){
                            var key = widgetContext.key;
                            for(var model in dataModels) {
                              if(model['identifier'].toString() == key) {
                                var modelData = model;
                                modelData['value'] = 'clicked';
                                finalFieldTrackData.add(modelData);
                                debugPrint("Model Data :: $modelData");
                              }
                            }
                          }
                        }
                      }


                      // final match = RegExp(r'(\w+)(?:\(dependencies|-\[)').firstMatch(widContext);
                      // debugPrint("WidgetType: ${match?.group(1)}");
                      // //changes
                      // var widget = extractFirstWord(widContext.toString());
                      // switch(widget) {
                      //   case "ElevatedButtonStyle":
                      //   case "TextButton":
                      //   case "IconButton":
                      //   case "FloatingActionButton":
                      //   case "InkWell":
                      //   case "GestureDetector":
                      //   case "Text":
                      //     debugPrint("Widget Clicked");
                      //     for(var data in widgetContexts) {
                      //       for(var widgetContext in data.entries) {
                      //         if(widgetContext.value == value){
                      //           var key = widgetContext.key;
                      //           for(var model in dataModels) {
                      //             if(model['identifier'] == key) {
                      //               var modelData = model;
                      //               modelData['value'] = 'clicked';
                      //               finalFieldTrackData.add(modelData);
                      //             }
                      //           }
                      //         }
                      //       }
                      //     }
                      //     break;
                      //
                      // }

                      debugPrint("Clicked Widget(WL): $value}");
                      shouldBreak = true;
                      break;
                    }
                  }
                }
              }
            } else {
              var textWidget = value.widget as EditableText;
              TextEditingController controller = textWidget.controller;

              addDataToList(){
                int i=0;
                for(var data in widgetContexts) {
                      var key = getKey(value);
                      for(var model in dataModels) {
                        if(model['identifier'] == key) {
                          var modelData = model;
                          var traverseClass = TraverseClass();
                          if(controller.text.toString() != ''){
                            if(i==0) {
                              i++;
                              prevTextFieldData = controller.text.toString();
                              modelData['value'] = controller.text.toString();
                              finalFieldTrackData.add(modelData);
                            }
                          }
                        }
                      }
                  }
              }
              var values =controller.value;
              textFieldListener() {
                debugPrint("Text Editing: ${controller.text}");
                addDataToList();
              }
              controller.addListener(textFieldListener);

            }
            // debugPrint("FINAL LIST: $finalFieldTrackData");
          }
        }
        // if (isDropDownButton) {
        //   for (var widget in widgetContexts) {
        //     if (shouldBreak) return;
        //     var currentRenderBox = widget.findRenderObject() as RenderBox?;
        //     if (currentRenderBox != null) {
        //       final position = currentRenderBox.localToGlobal(Offset.zero);
        //       final size = currentRenderBox.size;
        //       left = position.dx;
        //       top = position.dy;
        //       height = size.height;
        //       width = size.width;
        //       for (int i = left.toInt(); i <= left.toInt() + width.toInt(); i++) {
        //         for (int j = top.toInt(); j <=
        //             top.toInt() + height.toInt(); j++) {
        //           if (localPosition.dx.toInt() == i &&
        //               localPosition.dy.toInt() == j) {
        //             debugPrint("Clicked Widget(WL): $widget}");
        //             shouldBreak = true;
        //             // if(isDropDownButton) {
        //             //   for(var dropDownWidget in dropDownContexts) {
        //             //     debugPrint("DropDownWidget Values: ${dropDownWidget.widget.value}");
        //             //   }
        //             // }
        //             isDropDownButton = false;
        //             break;
        //           }
        //         }
        //       }
        //     }
        //   }
        //   if(isDropDownButton) {
        //     for(var dropDownWidget in dropDownContexts) {
        //       debugPrint("DropDownWidget Values: ${dropDownWidget.widget.value}");
        //     }
        //   }
        // }
      }
    } catch(e) {
      debugPrint("Global Pointer Exception");
    }
  }



  _traverseWidget(BuildContext context, List<Widget> widgets) {
    currentWidget = context.widget;
    var currentContext = context;
    mapWidgetData = {};
    Map<String, dynamic> idWithContext = {};

    if(context.widget is DropdownButton) {
      debugPrint("DropDown Button found");

      dropDownContexts.add(context);
      // widgetContexts.add(context);

      var widget = currentWidget as DropdownButton;
      List<DropdownMenuItem>? list = widget.items;
      for(DropdownMenuItem item in list!) {
        debugPrint("Item: ${item.value}");
      }
      debugPrint("DropDown Items: $list");

      category = context.widget.runtimeType.toString();
      var wid = context.widget as DropdownButton;
      ///gets x,y position and height and width of current widget
      getWidgetPosition(context);
      ///assigning values to map[mapWidgetData]
      mapWidgetData["activityName"] = activityName;
      mapWidgetData["screenName"] = screenName;
      mapWidgetData["category"] = category;
      mapWidgetData["viewType"] = viewType;
      mapWidgetData["subviews"] = subviews;
      mapWidgetData["isShow"] = isShow;
      mapWidgetData["id"] = context.widget.hashCode;
      mapWidgetData["testId"] = 0;
      mapWidgetData["currentID"] = "${wid.runtimeType}${dropDownCount++}";
      mapWidgetData["count"] = 0;
      mapWidgetData["left"] = left;
      mapWidgetData["top"] = top;
      mapWidgetData["height"] = height;
      mapWidgetData["width"] = width;
      mapWidgetData["scrollX"] = scrollX;
      mapWidgetData["scrollY"] = scrollY;
      mapWidgetData["translationX"] = translationX;
      mapWidgetData["translationY"] = translationY;

      mapWidgetData["viewId"] = "${wid.runtimeType}${dropDownCount++}";
      debugPrint("RadioBtnShort: ${wid.toStringShort()}");

      //changes
      idWithContext["${wid.runtimeType}${dropDownCount++}"] = context.widget;
      widgetContexts.add(idWithContext);

      widgetList.add(mapWidgetData);
    }
    if(context.widget is Radio) {
      debugPrint("RADIO btn found");
      // widgetContexts.add(context);

      category = context.widget.runtimeType.toString();
      var wid = context.widget as Radio;
      ///gets x,y position and height and width of current widget
      getWidgetPosition(context);
      ///assigning values to map[mapWidgetData]
      mapWidgetData["activityName"] = activityName;
      mapWidgetData["screenName"] = screenName;
      mapWidgetData["category"] = category;
      mapWidgetData["viewType"] = viewType;
      mapWidgetData["subviews"] = subviews;
      mapWidgetData["isShow"] = isShow;
      mapWidgetData["id"] = context.widget.hashCode;
      mapWidgetData["testId"] = 0;
      mapWidgetData["currentID"] = "${wid.runtimeType}${radioCount++}";
      mapWidgetData["count"] = 0;
      mapWidgetData["left"] = left;
      mapWidgetData["top"] = top;
      mapWidgetData["height"] = height;
      mapWidgetData["width"] = width;
      mapWidgetData["scrollX"] = scrollX;
      mapWidgetData["scrollY"] = scrollY;
      mapWidgetData["translationX"] = translationX;
      mapWidgetData["translationY"] = translationY;

      mapWidgetData["viewId"] = "${wid.runtimeType}${radioCount++}";
      debugPrint("RadioBtnShort: ${wid.toStringShort()}");

      //changes
      idWithContext["${wid.runtimeType}${radioCount++}"] = context.widget;
      widgetContexts.add(idWithContext);

      widgetList.add(mapWidgetData);

    }
    if(context.widget is EditableText) {
      var editableTextWidget = currentWidget as EditableText;
      var wid = context.findAncestorWidgetOfExactType<TextField>();

      TextEditingController? textEditingController = editableTextWidget.controller;
      editableTextCallBack() {
        debugPrint("EditableText listener called - ${textEditingController.text}");
      }
     // textEditingController.addListener(editableTextCallBack);

      debugPrint("TextFieldViewId: ${wid?.decoration?.labelText}");

      category=currentWidget.runtimeType.toString();
      ///gets x,y position and height and width of current widget
      getWidgetPosition(context);
      ///assigning values to map[mapWidgetData]
      mapWidgetData["activityName"] = activityName;
      mapWidgetData["screenName"] = screenName;
      mapWidgetData["category"] = category;
      mapWidgetData["viewType"] = viewType;
      mapWidgetData["subviews"] = subviews;
      mapWidgetData["isShow"] = isShow;
      mapWidgetData["id"] = context.widget.hashCode;
      mapWidgetData["testId"] = 0;
      mapWidgetData["currentID"] = "${wid?.decoration?.labelText}Tf";
      mapWidgetData["count"] = 0;
      mapWidgetData["left"] = left;
      mapWidgetData["top"] = top;
      mapWidgetData["height"] = height;
      mapWidgetData["width"] = width;
      mapWidgetData["scrollX"] = scrollX;
      mapWidgetData["scrollY"] = scrollY;
      mapWidgetData["translationX"] = translationX;
      mapWidgetData["translationY"] = translationY;

      //Get ViewId

      mapWidgetData["viewId"] = "${wid?.decoration?.labelText}Tf";

      //changes
      idWithContext["${wid?.decoration?.labelText}Tf"] = context;
      widgetContexts.add(idWithContext);

      widgetList.add(mapWidgetData);
    }
    if(context.widget is Semantics){
      var semanticsWidget = context.widget as Semantics;
      var imgWidget = context.findAncestorWidgetOfExactType<Image>();
      if(imgWidget != null){
      //   var img =imgWidget.image as AssetImage;
      //   var name = img.assetName;
      //   debugPrint('AssetName :: $name');
      // Widget? semanticsChild =  semanticsWidget.child as Widget;


        try{
          var img2 = imgWidget.image as NetworkImage;
          if(img2 != null){
           var imgUrl = img2.url;
                //debugPrint("Network Image url:: $imgUrl");
          }
        }catch(e){
          //debugPrint("NetworKImage error: $e");
        }

      }
     // debugPrint("nImg");
    }


    switch (currentWidget.runtimeType) {
      case GestureDetector:
        var widget = currentWidget as GestureDetector;
        RenderObject? renderObject = context.findRenderObject();

        var elevatedButton = context.findAncestorWidgetOfExactType<ElevatedButton>();
        var textButton = context.findAncestorWidgetOfExactType<TextButton>();
        var iconButton = context.findAncestorWidgetOfExactType<IconButton>();
        var inkWellButton = context.findAncestorWidgetOfExactType<InkWell>();
        var floatingActionButton = context.findAncestorWidgetOfExactType<FloatingActionButton>();
        var radio = context.findAncestorWidgetOfExactType<Radio>();
        var checkBox = context.findAncestorWidgetOfExactType<Checkbox>();
        var switchBtn = context.findAncestorWidgetOfExactType<Switch>();
        var dropDownBtn = context.findAncestorWidgetOfExactType<DropdownButton>();
        var dropDownMenuItem = context.findAncestorWidgetOfExactType<DropdownMenuItem>();
        var editableText = context.findAncestorWidgetOfExactType<EditableText>();


        if(textButton != null || elevatedButton != null || iconButton != null || inkWellButton != null || floatingActionButton != null || radio != null || checkBox != null || switchBtn != null || dropDownBtn != null || dropDownMenuItem != null) {

        } else {
          // widgetContexts.add(currentContext);

          category=currentWidget.runtimeType.toString();
          var wid = currentWidget as GestureDetector;
          ///gets x,y position and height and width of current widget
          getWidgetPosition(context);
          ///assigning values to map[mapWidgetData]
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = wid.hashCode;
          mapWidgetData["testId"] = 0;

          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          if(wid.child is Text) {
            var text = wid.child as Text;
           // debugPrint("InkWellText: ${text.data}");
            mapWidgetData["viewId"] = "${text.data}GBtn";
            mapWidgetData["currentID"] = "${text.data}GBtn";

            //changes
            idWithContext["${text.data}GBtn"] = currentContext;
            widgetContexts.add(idWithContext);

           // debugPrint("Check Text: GS ${mapWidgetData["viewId"]}");

          } else if(wid.child is Image) {
            var img = wid.child as Image;
            AssetImage assetImage = img.image as AssetImage;
            mapWidgetData["viewId"] = "${assetImage.assetName}GBtn";
            mapWidgetData["currentID"] = "${assetImage.assetName}GBtn";

            //changes
            idWithContext["${assetImage.assetName}GBtn"] = currentContext;
            widgetContexts.add(idWithContext);

          //  debugPrint("Check ImageId: GS ${mapWidgetData["viewId"]}");
          } else if(wid.child is Icon) {
            var icon = wid.child as Icon;
            IconData iconData = icon.icon as IconData;
            var iconName = iconData.toString();
            mapWidgetData["viewId"] = "${iconName}GBtn";
            mapWidgetData["currentID"] = "${iconName}GBtn";
            //changes
            idWithContext["${iconName}GBtn"] = currentContext;
            widgetContexts.add(idWithContext);

          //  debugPrint("Check IconId: GS ${mapWidgetData["viewId"]}");
          }
          // else if(wid.child is Column || wid.child is Row || wid.child is Container) {
          //   Widget? child = wid.child;
          //   traverseInnerContainers(currentContext, child);
          //
          // }
          ///assigning [mapWidgetData] Map to [widgetList] List

          widgetList.add(mapWidgetData);

        }
        break;

      // case ElevatedButton:
      // // widgetContexts.add(context);
      //   category=currentWidget.runtimeType.toString();
      //   var wid = currentWidget as ElevatedButton;
      //   ///gets x,y position and height and width of current widget
      //   getWidgetPosition(context);
      //   ///assigning values to map[mapWidgetData]
      //   mapWidgetData["activityName"] = activityName;
      //   mapWidgetData["screenName"] = screenName;
      //   mapWidgetData["category"] = category;
      //   mapWidgetData["viewType"] = viewType;
      //   mapWidgetData["subviews"] = subviews;
      //   mapWidgetData["isShow"] = isShow;
      //   mapWidgetData["id"] = wid.hashCode;
      //   mapWidgetData["testId"] = 0;
      //
      //   mapWidgetData["count"] = 0;
      //   mapWidgetData["left"] = left;
      //   mapWidgetData["top"] = top;
      //   mapWidgetData["height"] = height;
      //   mapWidgetData["width"] = width;
      //   mapWidgetData["scrollX"] = scrollX;
      //   mapWidgetData["scrollY"] = scrollY;
      //   mapWidgetData["translationX"] = translationX;
      //   mapWidgetData["translationY"] = translationY;
      //
      //
      //   if(wid.child is Text) {
      //     var text = wid.child as Text;
      //     debugPrint("EL TEXT: ${text.data.hashCode}");
      //     mapWidgetData["viewId"] = "${text.data}EBtn";
      //     mapWidgetData["currentID"] = "${text.data}EBtn";
      //
      //     //changes
      //     idWithContext["${text.data}EBtn"] = currentContext;
      //     widgetContexts.add(idWithContext);
      //   }
      //   ///assigning [mapWidgetData] Map to [widgetList] List
      //
      //
      //   widgetList.add(mapWidgetData);
      //
      //   break;

      case TextField:

        textFieldContext.add(context);

        break;

      case ElevatedButton:
      // widgetContexts.add(context);
        var isInsideList = context.findAncestorWidgetOfExactType<ListView>();
        // if(isInsideList == null) {
        category=currentWidget.runtimeType.toString();
        var wid = currentWidget as ElevatedButton;
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData = {};
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;

        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;


        if(wid.child is Text) {
          var text = wid.child as Text;
         // debugPrint("EL TEXT: ${text.data.hashCode}");
          mapWidgetData["viewId"] = "${text.data}EBtn";
          mapWidgetData["currentID"] = "${text.data}EBtn";

          //changes
          if(isInsideList == null) {
            idWithContext["${text.data}EBtn"] = currentContext;
            widgetContexts.add(idWithContext);
            widgetList.add(mapWidgetData);
          }
        }
        ///assigning [mapWidgetData] Map to [widgetList] List

        // }

        break;
      case TextButton:
      // widgetContexts.add(context);

        category=currentWidget.runtimeType.toString();
        var wid = currentWidget as TextButton;
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;

        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;


        if(wid.child is Text) {
          var text = wid.child as Text;
        //  debugPrint("TEXTBTNTEXT: ${text.data}");
          mapWidgetData["viewId"] = "${text.data}TBtn";
          mapWidgetData["currentID"] = "${text.data}TBtn";

          //changes
          idWithContext["${text.data}TBtn"] = currentContext;
          widgetContexts.add(idWithContext);
        }
        ///assigning [mapWidgetData] Map to [widgetList] List
        widgetList.add(mapWidgetData);

        break;
      case ListView:
        var listView = currentWidget as ListView;
       var scrollControl = listView.controller;
       if(scrollControl != null){
         debugPrint("");
       }
        final elements = listView.childrenDelegate;
        final count = listView.childrenDelegate.estimatedChildCount ?? 0;
        if(elements is SliverChildBuilderDelegate) {
          for(int elementIndex = 0; elementIndex <  count; elementIndex++) {
            final elementWidget = elements.builder(context, elementIndex);
            if(elementWidget is Column) {
              var columnWidget = elementWidget as Column;
              for(var columnChild in columnWidget.children) {

                if(columnChild is ElevatedButton) {
                  var eBtnInsideColumn = columnChild as ElevatedButton;
                  category=currentWidget.runtimeType.toString();
                  ///gets x,y position and height and width of current widget
                  getWidgetPosition(context);
                  mapWidgetData = {};
                  ///assigning values to map[mapWidgetData]
                  mapWidgetData["activityName"] = activityName;
                  mapWidgetData["screenName"] = screenName;
                  mapWidgetData["category"] = category;
                  mapWidgetData["viewType"] = viewType;
                  mapWidgetData["subviews"] = subviews;
                  mapWidgetData["isShow"] = isShow;
                  mapWidgetData["id"] = eBtnInsideColumn.hashCode;
                  mapWidgetData["testId"] = 0;
                  mapWidgetData["viewId"] = "${eBtnInsideColumn.child as Text}EBtnList$elementIndex";
                  mapWidgetData["currentID"] = "${eBtnInsideColumn.child as Text}EBtnList$elementIndex";
                  mapWidgetData["count"] = 0;
                  mapWidgetData["left"] = left;
                  mapWidgetData["top"] = top;
                  mapWidgetData["height"] = height;
                  mapWidgetData["width"] = width;
                  mapWidgetData["scrollX"] = scrollX;
                  mapWidgetData["scrollY"] = scrollY;
                  mapWidgetData["translationX"] = translationX;
                  mapWidgetData["translationY"] = translationY;

                  //changes
                  idWithContext["${eBtnInsideColumn.child as Text}EBtnList$elementIndex"] = currentContext;
                  widgetContexts.add(idWithContext);
                  widgetList.add(mapWidgetData);

                  //debugPrint("eBtn inside Column: ${eBtnInsideColumn.child}");
                } else if(columnChild is Text) {
                  var textInsideColumn = columnChild as Text;
                  category=currentWidget.runtimeType.toString();
                  ///gets x,y position and height and width of current widget
                  getWidgetPosition(context);
                  mapWidgetData = {};
                  ///assigning values to map[mapWidgetData]
                  mapWidgetData["activityName"] = activityName;
                  mapWidgetData["screenName"] = screenName;
                  mapWidgetData["category"] = category;
                  mapWidgetData["viewType"] = viewType;
                  mapWidgetData["subviews"] = subviews;
                  mapWidgetData["isShow"] = isShow;
                  mapWidgetData["id"] = textInsideColumn.hashCode;
                  mapWidgetData["testId"] = 0;
                  mapWidgetData["viewId"] = "${textInsideColumn.data}TxtList$elementIndex";
                  mapWidgetData["currentID"] = "${textInsideColumn.data}TxtList$elementIndex";
                  mapWidgetData["count"] = 0;
                  mapWidgetData["left"] = left;
                  mapWidgetData["top"] = top;
                  mapWidgetData["height"] = height;
                  mapWidgetData["width"] = width;
                  mapWidgetData["scrollX"] = scrollX;
                  mapWidgetData["scrollY"] = scrollY;
                  mapWidgetData["translationX"] = translationX;
                  mapWidgetData["translationY"] = translationY;

                  //changes
                  idWithContext["${textInsideColumn.data}TxtList$elementIndex"] = currentContext;
                  widgetContexts.add(idWithContext);
                  widgetList.add(mapWidgetData);

                 // debugPrint("Text inside Column: ${textInsideColumn.data}");
                }
              }
            }
          }
        }
        break;
      case IconButton:
      // widgetContexts.add(context);

        category=currentWidget.runtimeType.toString();
        var wid = currentWidget as IconButton;
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;

        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        var icon = wid.icon as Icon;
        //debugPrint("ICON DATA: $icon");
        IconData iconData = icon.icon as IconData;
        String iconName = iconData.toString();
        //debugPrint('Icon Name: $iconName');

        mapWidgetData["viewId"] = "${iconName}IBtn";
        mapWidgetData["currentID"] = "${iconName}IBtn";
        ///assigning [mapWidgetData] Map to [widgetList] List

        //changes
        idWithContext["${iconName}IBtn"] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;

      case FloatingActionButton:
      // widgetContexts.add(context);

        category=currentWidget.runtimeType.toString();
        var wid = currentWidget as FloatingActionButton;
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;

        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        if(wid.child is Text) {
          var text = wid.child as Text;
         // debugPrint("FABTEXT: ${text.data}");
          mapWidgetData["viewId"] = "${text.data}FBtn";
          mapWidgetData["currentID"] = "${text.data}FBtn";

          //changes
          idWithContext["${text.data}FBtn"] = currentContext;
          widgetContexts.add(idWithContext);

        } else if(wid.child is Icon) {
          var icon = wid.child as Icon;
         // debugPrint("ICON DATA: $icon");
          IconData iconData = icon.icon as IconData;
          String iconName = iconData.toString();
         // debugPrint('Icon Name: $iconName');
          mapWidgetData["viewId"] = "${iconName}FBtn";
          mapWidgetData["currentID"] = "${iconName}FBtn";

          //changes
          idWithContext["${iconName}FBtn"] = currentContext;
          widgetContexts.add(idWithContext);

        } else if(wid.child is AssetImage) {
          AssetImage img = wid.child as AssetImage;
          mapWidgetData["viewId"] = "${img.assetName}FBtn";
          mapWidgetData["currentID"] = "${img.assetName}FBtn";

          //changes
          idWithContext["${img.assetName}FBtn"] = currentContext;
          widgetContexts.add(idWithContext);

        }
        ///assigning [mapWidgetData] Map to [widgetList] List
        widgetList.add(mapWidgetData);


        break;

      case Switch:
      // widgetContexts.add(context);

        category=currentWidget.runtimeType.toString();
        var wid = currentWidget as Switch;
        count++;
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;

        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        mapWidgetData["viewId"] = "${wid.toStringShort()}${switchCount++}";
        mapWidgetData["currentID"] = "${wid.toStringShort()}${switchCount++}";
        // debugPrint("SwitchViewId: ${wid.toStringShort()}${switchCount++}");
       // debugPrint("SwitchViewId: ${mapWidgetData['viewId']}");
        ///assigning [mapWidgetData] Map to [widgetList] List

        //changes
        idWithContext["${wid.toStringShort()}${switchCount++}"] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;

      case Checkbox:
      // widgetContexts.add(context);
        var wid = currentWidget as Checkbox;
        category=currentWidget.runtimeType.toString();
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        var checkBoxId= "${wid.runtimeType}${checkBoxCount++}";
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = wid.hashCode;
        mapWidgetData["testId"] = 0;
        mapWidgetData["currentID"] = checkBoxId;
        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        mapWidgetData["viewId"] = checkBoxId;

        // debugPrint("CheckboxViewId: ${wid.toStringShort()}${checkBoxCount++}");
       // debugPrint("CheckboxViewId: ${mapWidgetData['viewId']}");
        ///assigning [mapWidgetData] Map to [widgetList] List

        //changes
        idWithContext[checkBoxId] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;

      case InkWell:
    try{
        inkWellContext.add(context);
        // var elevatedButton = context.findAncestorWidgetOfExactType<ElevatedButton>();
        // var dropDownButton = context.findAncestorWidgetOfExactType<DropdownButton>();
        // var floatingActionButton = context.findAncestorWidgetOfExactType<FloatingActionButton>();
        // var gestureDetectorButton = context.findAncestorWidgetOfExactType<GestureDetector>();
        //
        // if(elevatedButton != null || dropDownButton != null || floatingActionButton != null) {
        //   //InkWell of type elevatedButton or dropDownButton or floatingActionButton
        // } else if(currentWidget is GestureDetector) {
        //   //InkWell of type gestureDetectorButton
        // } else {
        //   // widgetContexts.add(context);
        //
        //   category=currentWidget.runtimeType.toString();
        //   var wid = currentWidget as InkWell;
        //   ///gets x,y position and height and width of current widget
        //   getWidgetPosition(context);
        //   ///assigning values to map[mapWidgetData]
        //   mapWidgetData["activityName"] = activityName;
        //   mapWidgetData["screenName"] = screenName;
        //   mapWidgetData["category"] = category;
        //   mapWidgetData["viewType"] = viewType;
        //   mapWidgetData["subviews"] = subviews;
        //   mapWidgetData["isShow"] = isShow;
        //   mapWidgetData["id"] = wid.hashCode;
        //   mapWidgetData["testId"] = 0;
        //
        //   mapWidgetData["count"] = 0;
        //   mapWidgetData["left"] = left;
        //   mapWidgetData["top"] = top;
        //   mapWidgetData["height"] = height;
        //   mapWidgetData["width"] = width;
        //   mapWidgetData["scrollX"] = scrollX;
        //   mapWidgetData["scrollY"] = scrollY;
        //   mapWidgetData["translationX"] = translationX;
        //   mapWidgetData["translationY"] = translationY;
        //
        //   if(wid.child is Text) {
        //     var text = wid.child as Text;
        //     debugPrint("InkWellText: ${text.data}");
        //     mapWidgetData["viewId"] = "${text.data}IwBtn";
        //     mapWidgetData["currentID"] = "${text.data}IwBtn";
        //
        //     //changes
        //     idWithContext["${text.data}IwBtn"] = currentContext;
        //   //  widgetContexts.add(idWithContext);
        //
        //   }else{
        //     Widget widget = wid.child as Widget;
        //
        //     if(widget is Column || widget is Row || widget is Container){
        //
        //       debugPrint("Correct");
        //     }else{
        //      // traverseInnerContainers(context);
        //
        //     }
        //   }
        //
        //   ///assigning [mapWidgetData] Map to [widgetList] List
        //   widgetList.add(mapWidgetData);
        //
        // }
    }catch(e){
     // debugPrint("Inkwell error $e");
    }

        break;

      case Text:
        var textWidget = currentWidget as Text;
        category=currentWidget.runtimeType.toString();
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = textWidget.hashCode;
        mapWidgetData["testId"] = 0;
        mapWidgetData["viewId"] = "${textWidget.data}Txt";
        mapWidgetData["currentID"] = "${textWidget.data}Txt";
        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        //changes
        idWithContext["${textWidget.data}Txt"] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;

      case SizedBox:
        var sizedBoxWidget = currentWidget as SizedBox;

        category=currentWidget.runtimeType.toString();
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = sizedBoxWidget.hashCode;
        mapWidgetData["testId"] = 0;
        mapWidgetData["viewId"] = "${sizedBoxWidget.width}-${sizedBoxWidget.height}SBox";
        mapWidgetData["currentID"] = "${sizedBoxWidget.width}-${sizedBoxWidget.height}SBox";
        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        //changes
        idWithContext["${sizedBoxWidget.width}-${sizedBoxWidget.height}SBox"] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;

      case Icon:
        var iconWidget = currentWidget as Icon;
        IconData? iconData = iconWidget.icon;
        var iconName = iconData.toString();

        category=currentWidget.runtimeType.toString();
        ///gets x,y position and height and width of current widget
        getWidgetPosition(context);
        ///assigning values to map[mapWidgetData]
        mapWidgetData["activityName"] = activityName;
        mapWidgetData["screenName"] = screenName;
        mapWidgetData["category"] = category;
        mapWidgetData["viewType"] = viewType;
        mapWidgetData["subviews"] = subviews;
        mapWidgetData["isShow"] = isShow;
        mapWidgetData["id"] = iconWidget.hashCode;
        mapWidgetData["testId"] = 0;
        mapWidgetData["viewId"] = "${iconName}Icon";
        mapWidgetData["currentID"] = "${iconName}SBox";
        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;

        //changes
        idWithContext["${iconName}SBox"] = currentContext;
        widgetContexts.add(idWithContext);

        widgetList.add(mapWidgetData);

        break;
      case Image:
        var imgWidget = currentWidget as Image;
        late BuildContext inkWellWidgetContext;
        var listViewWidget = context.findAncestorWidgetOfExactType<ListView>();
        var inkWellWidget = context.findAncestorWidgetOfExactType<InkWell>();
        if(listViewWidget != null && inkWellWidget != null){
          if(inkWellContext != null){
            for(var inkContext in inkWellContext){
              if(inkContext.widget == inkWellWidget){
                inkWellWidgetContext = inkContext;
              }
            }
          }
          var imgData = '';
        if (imgWidget.image is NetworkImage){
          try{
            var networkImageWidget = imgWidget.image as NetworkImage;
            imgData = '${networkImageWidget.url}NImg';
            // debugPrint("Network Image url:: $imgData");
          }catch(e){
            debugPrint("NetworKImage error: $e");
          }
        } else if(imgWidget.image is AssetImage){
            try{
              var assetImgWidget =imgWidget.image as AssetImage;
              imgData = '${assetImgWidget.assetName}AImg';
             // debugPrint('AssetName :: $imgData');
            }catch(e){
             // debugPrint("Not AssetImage Instance!!");
            }
          }

          category=inkWellWidget.runtimeType.toString();
          ///gets x,y position and height and width of current widget
          getWidgetPosition(inkWellWidgetContext);
          ///assigning values to map[mapWidgetData]
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = inkWellWidget.hashCode;
          mapWidgetData["testId"] = 0;

          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;

            mapWidgetData["viewId"] = imgData;
            mapWidgetData["currentID"] = imgData;
            //changes
            idWithContext[imgData] = inkWellWidgetContext;
            widgetContexts.add(idWithContext);
          ///assigning [mapWidgetData] Map to [widgetList] List
          widgetList.add(mapWidgetData);

        }
       break;
      default:
        {
          //print("WidgetType does not match");
        }
        break;
    }
    ///reassigning [viewId] and [currentId] to default
    viewId="";
    currentID="";
    ///for recursive calling of [_traverseWidget] method for traversing child or children of widgets
    final element = context as Element;

    element.visitChildren((child) {
      _traverseWidget(child, widgets);
    });
  }

  traverseInnerContainers(BuildContext context) {
    var currentWidget = context.widget;
    if(currentWidget is Text){
     // debugPrint("text");
    }
    switch(currentWidget.runtimeType) {
      case Row:
        var wid = currentWidget as Row;
      //  debugPrint("Row found");
        List<Widget>? children = wid.children;
       // debugPrint("Row Children: $children");
        break;
      case Column:
        var wid = currentWidget as Column;
      //  debugPrint("Column found");
        List<Widget>? children = wid.children;
      //  debugPrint("Column Children: $children");
        traverseInnerContainers(context);
        break;
      case Container:
        var wid = currentWidget as Container;
     //   debugPrint("Container found");
        List<Widget>? children = wid.child as List<Widget>?;
       // debugPrint("Column Children: $children");
        break;
      case Text:
        var textWidget = context.widget as Text;
        var textData = textWidget.data;
        return "${textData!}Txt";
    }

    viewId="";
    currentID="";
    final element = context as Element;
    element.visitChildren((child) {
      traverseInnerContainers(child);
    });
  }


  void getWidgetPosition(currentContext) async {
    final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      left=position.dx;
      top=position.dy;
      height=size.height;
      width=size.width;
    }
  }



  Map getWidgetPositions(currentContext) {
    final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      left=position.dx;
      top=position.dy;
      height=size.height;
      width=size.width;
      Map<dynamic, dynamic> positionValues = {'left' : left, 'top': top, 'height': height, 'width': width};
      return positionValues;
    }
    return {};
  }

  void findWidget(BuildContext context) {
    if(context is TextButton) {
      debugPrint("TextButton clicked");
    } else {
      debugPrint("Other than TextButton clicked");
    }
  }
  traverseChildren(context){
    final element = context as Element;
    switch(context.runtimeType){
      case Text:
        var textWidget = context.widget as Text;
        var textData = textWidget.data;
        return "${textData!}Txt";


    }

    element.visitChildren((child) {
      traverseChildren(child);
    });
  }

}


