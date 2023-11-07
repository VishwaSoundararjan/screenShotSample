import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
// import 'package:refluttersdk/refluttersdk_method_channel.dart';
import 'dart:io';

import 'package:screenshotsample/main.dart';

import 'fieldCapture.dart';

/// Sample field capture data
List dataModels = [
  {
    'screenName': 'UserForm',
    'eventName': 'Changing text event',
    'viewType': 'Value',
    'identifier': '15.0-143.63636363636363',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'UserForm',
    'campaignId': 71627,
  },
  {
    'screenName': 'UserForm',
    'eventName': 'Button Tap event',
    'viewType': 'Value',
    'identifier': '157.86363636363637-279.6363636363636',
    'captureType': 'Value',
    'markAsGoal': false,
    'mainScreenName': '',
    'activityName': 'UserForm',
    'campaignId': 71780,
  },
];


class ScreenTracking {

  late String activityName;
  late String screenName;
  late String category;
  late var data;
  late var className;
  late Map<String, dynamic> mapWidgetData;
  late List<Map<String, dynamic>> widgetList;


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
  String viewType = 'Others';
  String subviews = '';
  bool isShow = true;

  Future<List<Map<String,dynamic>>> traverseWidgetTree(BuildContext context) async {
    final widgets = <Widget>[];
    fetchData();
    ///gets current class name from the context and assign it to activityName
    activityName = context.widget.runtimeType.toString();
    screenName = activityName;
    ///initializing [widgetList] List
    widgetList = [];
   // _getScreenShot(context);

    _traverseWidget(context, widgets);
    //await _doTakeScreenshot();
   // print("Obtained List :: ${jsonEncode(widgetList)}");
    return widgetList;
  }

  _traverseWidget(BuildContext context, List<Widget> widgets)  async {
    Widget currentWidget = context.widget;
    ///Initializing Map to store the widget details
    mapWidgetData = {};
    ///get key of the current widget and assign it to viewId and currentID
    getWidgetKey(currentWidget);
    ///generates a random 10 digit number
    id=generateRandomNumber();

    if(currentWidget.runtimeType==TextField) {
      TextField as = currentWidget.runtimeType as TextField;

    }
// dropdownbtn, radio, editable text,

    ///Check if the current widget matches the desired conditions
    switch (currentWidget.runtimeType) {
      case Scaffold:{
        ///gets current Widget type
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
        mapWidgetData["id"] = id;
        mapWidgetData["viewId"] = viewId;
        mapWidgetData["testId"] = 0;
        mapWidgetData["currentID"] = currentID;
        mapWidgetData["count"] = 0;
        mapWidgetData["left"] = left;
        mapWidgetData["top"] = top;
        mapWidgetData["height"] = height;
        mapWidgetData["width"] = width;
        mapWidgetData["scrollX"] = scrollX;
        mapWidgetData["scrollY"] = scrollY;
        mapWidgetData["translationX"] = translationX;
        mapWidgetData["translationY"] = translationY;
        ///assigning [mapWidgetData] Map to [widgetList] List
        widgetList.add(mapWidgetData);
      }
      break;
      case AppBar:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case Stack:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case Container:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case Expanded:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case ListView:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case Card:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case TextField:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case Checkbox:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case RadioMenuButton:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case DropdownButton:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case InkWell:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case GestureDetector:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case Column:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          //
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case Row:
        {
          // category=currentWidget.runtimeType.toString();
          // getWidgetPosition(context);
          // mapWidgetData["activityName"] = activityName;
          // mapWidgetData["screenName"] = screenName;
          // mapWidgetData["category"] = category;
          // mapWidgetData["viewType"] = viewType;
          // mapWidgetData["subviews"] = subviews;
          // mapWidgetData["isShow"] = isShow;
          // mapWidgetData["id"] = id;
          // mapWidgetData["viewId"] = viewId;
          // mapWidgetData["testId"] = 0;
          // mapWidgetData["currentID"] = currentID;
          // mapWidgetData["count"] = 0;
          // mapWidgetData["left"] = left;
          // mapWidgetData["top"] = top;
          // mapWidgetData["height"] = height;
          // mapWidgetData["width"] = width;
          // mapWidgetData["scrollX"] = scrollX;
          // mapWidgetData["scrollY"] = scrollY;
          // mapWidgetData["translationX"] = translationX;
          // mapWidgetData["translationY"] = translationY;
          // widgetList.add(mapWidgetData);
        }
        break;
      case Text:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          if (currentWidget is Text) {
            data=currentWidget.data;
          }
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case ElevatedButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          checkFieldCapture(currentWidget);
          widgetList.add(mapWidgetData);
        }
        break;
      case TextButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case FloatingActionButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case OutlinedButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case IconButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case DropdownButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case PopupMenuButton:
        {
          category=currentWidget.runtimeType.toString();
          viewType="value";
          bool isShow=true;
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case Image:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case ListView:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case GridView:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case SizedBox:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      case Divider:
        {
          category=currentWidget.runtimeType.toString();
          getWidgetPosition(context);
          mapWidgetData["activityName"] = activityName;
          mapWidgetData["screenName"] = screenName;
          mapWidgetData["category"] = category;
          mapWidgetData["viewType"] = viewType;
          mapWidgetData["subviews"] = subviews;
          mapWidgetData["isShow"] = isShow;
          mapWidgetData["id"] = id;
          mapWidgetData["viewId"] = viewId;
          mapWidgetData["testId"] = 0;
          mapWidgetData["currentID"] = currentID;
          mapWidgetData["count"] = 0;
          mapWidgetData["left"] = left;
          mapWidgetData["top"] = top;
          mapWidgetData["height"] = height;
          mapWidgetData["width"] = width;
          mapWidgetData["scrollX"] = scrollX;
          mapWidgetData["scrollY"] = scrollY;
          mapWidgetData["translationX"] = translationX;
          mapWidgetData["translationY"] = translationY;
          widgetList.add(mapWidgetData);
        }
        break;
      default:
        {
          //print("WidgetType does not match");
        }
        break;
    }
    ///reassigning [viewId] and [currentID] to default
    viewId="";
    currentID="";
    ///for recursive calling of [_traverseWidget] method for traversing child or children of widgets
    final element = context as Element;
    element.visitChildren((child) {
      _traverseWidget(child, widgets);
    });
  }
  ///gets key of the current widget
  void getWidgetKey(currentWidget){
    if(currentWidget.key != null){
      //print("key:${currentWidget.key.toString()}");
      viewId=currentWidget.key.toString();
      currentID=viewId;
    }
  }
  ///gets x,y position and height and width of current widget
  void getWidgetPosition(currentContext) async {
    final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      left=position.dx;
      top=position.dy;
      height=size.height;
      width=size.width;
      // RenderRepaintBoundary boundary =currentContext.findRenderObject() as RenderRepaintBoundary;
      // ui.Image image = await boundary.toImage();
      // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      // if (byteData != null) {
      //   Uint8List pngBytes = byteData.buffer.asUint8List();
      // }
    }
  }
  ///generates random 10 digit number
  int generateRandomNumber() {
    Random random = Random();
    int min = 100000000;
    int max = 899999999;
    return min +1000000000+ random.nextInt(max - min);
  }

  Future<void> checkFieldCapture(Widget currentWidget) async {
    var key = "$left-$top";   //'15.0-143.63636363636363','157.86363636363637-279.6363636363636',
    for (var model in dataModels) {
      if(model["screenName"] == activityName && model["identifier"] == key)
     {
       _btnListener() {
         print('Material btn pressed!!!');
       }
        var widget = currentWidget as ElevatedButton;
       MaterialStatesController? statesControllers = widget
           .statesController;
       if(statesControllers != null) {
         // statesControllers?.update(MaterialState.disabled, false);
          statesControllers?.addListener(_btnListener);
       }
     }else {

      }
    }
  }

  Future<dynamic> fetchData() async {
    try {
      var result = await methodChannel.invokeMethod('getFieldTrackList');

      //getDataFromList(result);
      print(result.toString());
      // Check if the result is a List<dynamic> before processing
      if (result is List<dynamic>) {
        for (var element in result) {
          // Process each element here
          print("LISTEL: $element");
        }
      } else {
        // Handle cases where the result is not a List<dynamic>
        print('Result is not a List<dynamic>: $result');
      }
    } catch (error) {
      // Handle any errors that occurred during the Future execution.
      print('Get Field-track list Error: $error');
    }
    return null;
  }

  getDataFromList(dataList){
     dataModels = dataList.map((data) => FieldTrackDataModels.fromMap(data)).toList();

    for (var model in dataModels) {
      print('Screen Name: ${model.screenName}');
      print('Identifier: ${model.identifier}');
      print('Capture Type: ${model.captureType}');
      print('Campaign ID: ${model.campaignId}');
      print('Value: ${model.value}');
      print('Mark as Goal: ${model.markAsGoal}');
      print('Event Name: ${model.eventName}');
      print('--------------------------');
    }
  }



}