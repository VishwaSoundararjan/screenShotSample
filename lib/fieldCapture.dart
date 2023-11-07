// import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotsample/accessibility_plugin.dart';
import 'package:screenshotsample/forms.dart';
import 'package:screenshotsample/main.dart';
import 'package:screenshotsample/sample_page.dart';
import 'package:screenshotsample/traverse_widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final List<Map<String, String>> fieldCaptureData = [
  {'screenName': 'UserForm', "left": "15.0", "top": "143.63636363636363",'viewId': 'textField1','captureType': 'Value','value': ''},
  {'screenName': 'UserForm', "left": "15.0", "top": "211.63636363636363",'viewId': 'textField2','captureType': 'Value','value': ''},
  {'screenName': 'UserForm', "left": "157.86363636363637", "top": "279.6363636363636",'viewId': 'textField3','captureType': 'Click','value': ''},
 // {'screenName': 'UserForm', "left": "15.0", "top": "100.0",'viewId': 'btn','captureType': 'Click','value': ''},
];

var x = "";
var y = "";
var coordinates = "$x-$y";

late Map<dynamic,String> widgetData;
late List<dynamic> widgetDataList;
FlutterSecureStorage storage = const FlutterSecureStorage();
class FieldCapture{
  late List<Map<dynamic,dynamic>> storedData1;
  late List<Map<dynamic,dynamic>>  storedData2;
  late List<Map<dynamic,dynamic>> storedData3;
  late var fcData;
  late var submitFCData;
  late String currentWidgetKey;

  // void fieldCapture(BuildContext context) {
  //   if(context.widget.runtimeType.toString() == fieldCaptureData[0]["screenName"]){
  //      for(fcData in fieldCaptureData){
  //                         _fieldCapture(context);
  //
  //      }
  //     }
  //   }
  // GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
  // if(event is PointerDownEvent) {
  //
  // // if(//FInd the event occured widget) {
  // debugPrint("PointerDownEvent received: IconButton: ${context.widget.key}");
  // // }
  //
  // }
  // });

  late String screenName;
  void fieldCapture(BuildContext context) {
    //findRenderObject(context);
    //targetTapEvent(context);
    widgetDataList=[];
     screenName = context.runtimeType.toString();
        for(fcData in fieldCaptureData){
                _fieldCapture(context);
              }
       // storeListInPageStorage(context,screenName );
        flutterSecureStorage();
  }

  void storeListInPageStorage(BuildContext context, String screenName) {
    final PageStorageBucket bucket = PageStorage.of(context);
    bucket.writeState(context, widgetDataList, identifier: screenName);
    List<Map<dynamic,dynamic>> receivedDataList = bucket.readState(context, identifier: screenName);
  if(receivedDataList!=null){
     for(var data in receivedDataList){
       for( var data1 in widgetDataList){
         if(data.keys == data1.keys){
           debugPrint("keys are matching");
         }
         else{
           debugPrint("keys are not matching");
         }
       }
     }

  }
    // Store your data list in PageStorage using a unique key

  }
  flutterSecureStorage() async {
        try{
        var receivedDataList= await storage.read(key:screenName);
        List<dynamic> myList = List<dynamic>.from(json.decode(receivedDataList!));
        if(myList != null){
          for(var data in myList){
            for(var data1 in widgetDataList ){
              if(data == data1){
                debugPrint("Widgets are matching");
              }else{
                debugPrint("Widgets are not matching");
              }
            }
          }
        }
        }catch(e){
          debugPrint("Loop error :: $e");
        }
    storage.write(key: screenName, value: json.encode(widgetDataList));

  }
  _fieldCapture(BuildContext context){
    widgetData ={};

    final currentWidget = context.widget;
    // context.dependOnInheritedElement();
    // context.getElementForInheritedWidgetOfExactType();
    // context.visitChildElements((element) { });
    // context.dependOnInheritedWidgetOfExactType();

    if(context is DatePickerDialog){
      debugPrint("DatePicker Instance");
    }
    if(context is DateRangePickerDialog){
      debugPrint("DateRangePickerDialog Instance");
    }
    if(context is InputDatePickerFormField){
      debugPrint("InputDatePickerFormField Instance");
    }
    if(context is DatePickerDateTimeOrder){
      debugPrint("DatePickerDateTimeOrder Instance");
    }
    if(context is DateTimeRange){
      debugPrint("DateTimeRange Instance");
    }
    if(context is DatePickerDateOrder){
      debugPrint("DatePickerDateOrder Instance");
    }
    if(context is MyHomePage){
      debugPrint("MyHomePage Instance");
    }
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (true) {
      // final position = renderBox.localToGlobal(Offset.zero);
      // final size = renderBox.size;
      if (
      // position.dx.toString() == fcData["left"] &&
      //     position.dy.toString() == fcData["top"]
      true
      ) {
        switch (currentWidget.runtimeType) {
          case Text:
            {

            }
            break;
          // case TextField:
          //   {
          //     const Key stableKey = ValueKey<String>('myFixedKey');
          //
          //     final textFieldWidget = currentWidget as TextField;
          //
          //     /// Adding Listener to Focus Node
          //     FocusNode? txtFocus = textFieldWidget.focusNode;
          //     txtFocus?.addListener(() {
          //       if (txtFocus.hasFocus) {
          //         debugPrint('TextField Widget has gained focus');
          //         debugPrint(
          //             "TextField Key from Listener :: ${currentWidget.key}");
          //       } else {
          //         debugPrint('TextField Widget has lost focus');
          //       }
          //     });
          //
          //     /// Adding listener to Text Editing Controller
          //     try {
          //       TextEditingController controller = textFieldWidget
          //           .controller!;
          //       onControllerChanged() {
          //         debugPrint(
          //             "Text Controller value Changed: ${controller.text}");
          //       }
          //       controller.addListener(onControllerChanged);
          //     } catch (e) {
          //       debugPrint("$e");
          //     }
          //
          //     /// Adding listener to ScrollController
          //     ScrollController? textFieldScrollController = textFieldWidget
          //         .scrollController;
          //     textFieldScrollController?.addListener(() {
          //       debugPrint("Text Field Scroll Controller Listener");
          //     });
          //   }
          //   break;
          case ElevatedButton:
            {
              targetTapEvent(context);
              findRenderObject(context);
              widgetDataList.add(context);
              //
              // var btnWidget = currentWidget as ElevatedButton;
              // getWidgetPosition(context);
              //  context.findRootAncestorStateOfType();
              //  var ancestor = context.findAncestorWidgetOfExactType<InkWell>();
              //  if(ancestor != null){
              //    debugPrint("Ancestor :: $ancestor");
              //  }
              // /// Adding Listener to Focus Node
              // FocusNode? txtFocus = btnWidget.focusNode;
              // txtFocus?.addListener(() {
              //   if (txtFocus.hasFocus) {
              //     debugPrint('Button Widget has gained focus');
              //     debugPrint("Key from Listener :: ${currentWidget.key}");
              //   } else {
              //     debugPrint('Button Widget has lost focus');
              //     debugPrint(
              //         "Button Key from Listener :: ${currentWidget.key}");
              //   }
              // });
              //
              // /// Adding Listener to MaterialStateController
              // try {
              //   btnListener() {
              //     debugPrint('Button Listener Invoked!!!');
              //   }
              //   MaterialStatesController? statesControllers = btnWidget
              //       .statesController;
              //   statesControllers?.update(MaterialState.disabled, false);
              //   statesControllers?.addListener(btnListener);
              // } catch (e) {
              //   debugPrint("$e");
              // }
              //
              // VoidCallback? onPress = btnWidget.onPressed;
              //
              // VoidCallback? onlongpress = btnWidget.onLongPress;
              // // onlongpress?.call();
              //
              // ValueChanged<bool>? onchangefocus = btnWidget.onFocusChange;
              // // onchangefocus?.call(true);
              //
              // ValueChanged<bool>? onhover = btnWidget.onHover;
              // // onhover?.call(true);

            }
            break;
          // case InkWell :
          //   {
          //
          //     var inkwellWidget = currentWidget as InkWell;
          //     BuildOwner? buildOwner = context.owner as BuildOwner;
          //
          //    // var inheritedContext = MyInheritedWidget.of(context);
          //     debugPrint("InkWell key ${currentWidget.key.toString()}");
          //       MaterialStatesController? materialStatesController = inkwellWidget
          //           .statesController;
          //       inkWellListener() {
          //         debugPrint("Ink Well Material Listener called!!!");
          //       }
          //       materialStatesController?.addListener(inkWellListener);
          //     // ///DropDownMenuButton
          //     // final dropDownWidget = context.findAncestorWidgetOfExactType<DropdownMenuItem>();
          //     // if(dropDownWidget != null ){
          //     //
          //     //   MaterialStatesController? materialStatesController = inkwellWidget
          //     //       .statesController;
          //     //   inkWellListener() {
          //     //     debugPrint("Drop down listener called :: ${dropDownWidget.value}");
          //     //   }
          //     //   materialStatesController?.addListener(inkWellListener);
          //     // }
          //     //
          //     // ///Accessing the key by using its ancestorWidget
          //     // final buttonWidget = context.findAncestorWidgetOfExactType<TextField>();
          //     // if (buttonWidget != null) {
          //     //   var textFieldKey = buttonWidget.key;
          //     //   debugPrint("Key from Ink Text :: $textFieldKey");
          //     // }
          //     // final iconButtonWidget = context.findAncestorWidgetOfExactType<ButtonStyleButton>();
          //     // if (iconButtonWidget != null) {
          //     //   debugPrint("IconButton Widget is available!!!");
          //     // }
          //
          //     /// adding listener using MaterialStateController
          //     if (inkwellWidget.focusNode != null) {
          //       debugPrint("focus node not null");
          //       FocusNode? inkWellFocusNode = inkwellWidget.focusNode;
          //       inkWellFocusListener() {
          //         debugPrint("Inkwell-button focus listener called");
          //       }
          //       inkWellFocusNode?.addListener(inkWellFocusListener);
          //     }
          //
          //     //      MaterialStatesController? materialStatesController = inkwellWidget
          //     //          .statesController;
          //     //      inkWellListener() {
          //     //        debugPrint("Inkwell-button listener called");
          //     //      }
          //     //      materialStatesController?.addListener(inkWellListener);
          //
          //   }
          //   break;
          //case RawGestureDetector:
            // targetTapEvent(context);
           //  var focusWidget = currentWidget as RawGestureDetector;
           //  var iconButton = context.findAncestorWidgetOfExactType<IconButton>();
           //  InheritedWidget inheritedWidget = context as InheritedWidget;
           // Widget widgetChild = inheritedWidget.child;
           //  debugPrint("iconButton: RawGestureDetector: $iconButton");
           //  if(iconButton != null) {
           //    Map<Type, GestureRecognizerFactory> allGestures = focusWidget.gestures;
           //    final tapGestureRecognizer = TapGestureRecognizer();
           //
           //    tapGestureRecognizer.onTap = () {
           //      debugPrint("tapGestureRecognizer listener called");
           //    };
           //    focusWidget.gestures[TapGestureRecognizer] = GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
           //          () => tapGestureRecognizer,
           //          (TapGestureRecognizer instance) {},
           //    );
           //    debugPrint("GESTURES: $allGestures");

            //}
            break;
          // case EditableText :
          //   {
          //     var editableTextWidget = currentWidget as EditableText;
          //
          //     /// Accessing the key by using its ancestorWidget
          //     final textFieldWidget = context.findAncestorWidgetOfExactType<
          //         TextField>();
          //     if (textFieldWidget != null) {
          //       var textFieldKey = textFieldWidget.key;
          //       debugPrint("Key from Editable Text :: $textFieldKey");
          //     }
          //
          //     /// adding listener using MaterialStateController
          //
          //     TextEditingController? textEditingController = editableTextWidget
          //         .controller;
          //     editableTextCallBack() {
          //       debugPrint(
          //           "EditableText listener called - ${textEditingController
          //               .text}");
          //     }
          //     textEditingController?.addListener(editableTextCallBack);
          //   }
          //   break;
          // case IconButton :
          //   {
          //     var iconButtonContext = currentWidget as IconButton;
          //     //final myModel = context.watch<ChangeNotifier>();
          //
          //     //Material.of(context),
          //     //MaterialStatesController? materialStatesController = Material.of(context) as MaterialStatesController;
          //     iconButtonListener() {
          //       debugPrint("Icon Button - Listener called");
          //     }
          //     //myModel.addListener(iconButtonListener);
          //     context.owner?.focusManager.addListener(iconButtonListener);
          //     context.getElementForInheritedWidgetOfExactType();
          //     Theme.of(context);
          //   }
          //   break;
          case IconButton:
            var widget = currentWidget as IconButton;
             debugPrint("IconButton :: $widget");

        // Get the RenderObject of the IconButton
            targetTapEvent(context);
           //findRenderObject(context);
            break;
          // case DropdownMenuItem :
          //   {
          //     var dropDownButtonContext = currentWidget as DropdownMenuItem;
          //     if (dropDownButtonContext != null) {
          //       debugPrint("DropdownMenuItem widget called");
          //     }
          //   }
          //   break;
          // case Checkbox :
          //   {
          //     var dropDownButtonContext = currentWidget as Checkbox;
          //     if (dropDownButtonContext != null) {
          //       debugPrint("Check box widget called");
          //     }
          //   }
          //   break;
          // case FocusableActionDetector :
          //   {
          //     var dropDownButtonContext = currentWidget as FocusableActionDetector;
          //
          //     if (dropDownButtonContext != null) {
          //       FocusNode? focusNode = dropDownButtonContext.focusNode;
          //       customListener() {
          //         debugPrint("FocusableActionDetector - listener called");
          //       }
          //       focusNode?.addListener(customListener);
          //       debugPrint("FocusableActionDetector widget called");
          //     }
          //   }
          //   break;
          // case InkHighlight :
          //   {
          //     var inkHighlight = currentWidget as InkHighlight;
          //     var a = 10;
          //     MaterialInkController materialInkController = inkHighlight
          //         .controller;
          //   }
          //   break;
          // case InkResponse :
          //   {
          //     debugPrint("Contains InkResponse");
          //   }
          //   break;
          // case Action :
          //   {
          //     debugPrint("Contains Actions");
          //   }
          //   break;
        //   case Semantics:{
        //     var semantics = currentWidget as Semantics;
        //     debugPrint("SEMANTICS: $semantics");
        //     var iconButtonWidget = context.findAncestorWidgetOfExactType<
        //         IconButton>();
        //     debugPrint("SEMANTICS:IconButton: $iconButtonWidget");
        //     var checkBoxWidget = context.findAncestorWidgetOfExactType<
        //         Checkbox>();
        //     debugPrint("SEMANTICS:Checkbox: $checkBoxWidget");
        //     var switchWidget = context.findAncestorWidgetOfExactType<Switch>();
        //     debugPrint("SEMANTICS:SWITCH: $switchWidget");
        //     var floatingActionButtonWidget = context
        //         .findAncestorWidgetOfExactType<FloatingActionButton>();
        //     debugPrint(
        //         "SEMANTICS:FLOATINGACTIONBUTTON: $floatingActionButtonWidget");
        //     var widgetObj = context
        //         .findAncestorWidgetOfExactType<Widget>();
        //     if(widgetObj != null){
        //     debugPrint("Widget Obj data :: $widgetObj");
        //     }
        //     if (checkBoxWidget != null) {
        //       if (semantics.properties.checked != null) {
        //
        //         debugPrint(
        //             "SEMANTICS:CHECKED: ${semantics.properties.checked}");
        //       }
        //     } else if (switchWidget != null) {
        //       if (semantics.properties.enabled != null) {
        //         debugPrint(
        //             "SEMANTICS:SWITCH:VALUE: ${semantics.properties.enabled}");
        //       }
        //     } else if (floatingActionButtonWidget != null) {
        //       debugPrint("SEMANTICS:FLOATINGACTIONBUTTON:CLICK: ${semantics
        //           .properties}");
        //     } else if (iconButtonWidget != null) {
        //       debugPrint(
        //           "SEMANTICS:ICONBUTTON:CLICK: ${semantics.properties.onTap}");
        //       //CAN'T Listen click
        //     }
        // }
        //     break;
          // case Focus :{
          //  var focus = currentWidget as Focus;
          //  if(focus.focusNode != null){
          //    FocusNode focusNode = focus.focusNode as FocusNode;
          //    focusNode.addListener(() {debugPrint("New Focus Listener called"); });
          //  }
          //   debugPrint("Contains Focus");
          // }
          // break;
          // case RawMaterialButton :{
          //   var rawMaterialButton = currentWidget as RawMaterialButton;
          //   rawMaterialListener(){
          //     debugPrint("Raw Material List");
          //   }
          //   FocusNode? myFocusNode = rawMaterialButton.focusNode;
          //   rawMaterialButton.focusNode?.addListener(() { debugPrint("${myFocusNode?.hasFocus}"); });
          //  rawMaterialButton.focusNode?.addListener(rawMaterialListener);
          // }
          // break;
          // case RawGestureDetectorState :
          //   {
          //     RawGestureDetector rawGestureDetector = currentWidget as RawGestureDetector;
          //     Map<Type,
          //         GestureRecognizerFactory<
          //             GestureRecognizer>> gestures = rawGestureDetector
          //         .gestures;
          //     if (rawGestureDetector != null) {
          //       debugPrint("RawGestureDetector Instance");
          //       debugPrint("RawGesture Data :: ${rawGestureDetector.gestures}");
          //
          //       Type tapRecognizerType = TapGestureRecognizer;
          //       if (gestures.containsKey(tapRecognizerType)) {
          //         GestureRecognizerFactory<
          //             GestureRecognizer>? factory = gestures[tapRecognizerType];
          //         GestureRecognizerFactoryWithHandlers<TapGestureRecognizer> recognizer = factory! as GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>; // Create an instance of TapGestureRecognizer
          //
          //      //    final TapGestureRecognizer tapGestureRecognizer = recognizer as TapGestureRecognizer;
          //      //    tapGestureRecognizer.onTap = () {
          //      //      // Your custom onTap handler code here.
          //      //      print('Tapped on RawGestureDetector!');
          //      //    };
          //      //    debugPrint("Gesture Factory :: $recognizer");
          //      //  //recognizer.initializer(instance);
          //      //
          //       }
          //      // var tapGestureRecognizer = GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>;
          //
          //       debugPrint("RawGestureDetector Invoked");
          //     }
          //   }
          // break;
          case RawGestureDetector :{
            // RawGestureDetectorState rawGestureDetectorState = currentWidget as RawGestureDetectorState;
            // if(rawGestureDetectorState!=null){
            //   debugPrint("RawGestureDetectorState Instance");
            //   debugPrint("RawGesture Data :: ${rawGestureDetectorState.widget.gestures}");
            // }
            // debugPrint("RawGestureDetectorState Invoked");
            final ancestorWidget = context.findAncestorWidgetOfExactType<Widget>();
            InheritedElement? element = context.getElementForInheritedWidgetOfExactType<InheritedWidget>();
          if(element!=null){

          }
              final semanticsWidget = context.findAncestorWidgetOfExactType<Semantics>();
              if(semanticsWidget != null){
                debugPrint("Semantics Widget :: $semanticsWidget");
              }

            // targetTapEvent(context);
            if (ancestorWidget != null) {
              if (ancestorWidget is! ElevatedButton &&
                  ancestorWidget is! DropdownButton &&
                  ancestorWidget is! FloatingActionButton &&
                  ancestorWidget is! InkWell &&
                  ancestorWidget is! Radio &&
                  ancestorWidget is! Switch &&
                  ancestorWidget is! IconButton) {
                 targetTapEvent(context);
                //findRenderObject(context);
              } else {
              debugPrint("Condition Failed ${currentWidget.toString()}");
              }
            } else {

              debugPrint("Condition Failed ${currentWidget.toString()}");
              var mywidget = currentWidget as RawGestureDetector;
              AssetImage img = mywidget.child as AssetImage;
              var name = img.assetName;
              debugPrint("ImageNAme: $name");
            }

          }
          break;
          case Listener :{

            Listener listener = currentWidget as Listener;
            if(listener!= null){
              debugPrint("Listener Instance");
            }
            debugPrint("Listener Invoked");
          }
          break;
          case AnimatedBuilder :{
          debugPrint("AnimatedBuilder Instance");
          }
          break;
          case CalendarDatePicker :{
            CalendarDatePicker calendarDatePicker = currentWidget as CalendarDatePicker;
            if(calendarDatePicker != null){
              debugPrint("CalendarDatePicker Instance");
            }
            debugPrint("CalendarDatePicker Invoked");
          }
          break;
          case DateRangePickerDialog :{
            DateRangePickerDialog dateRangePickerDialog = currentWidget as DateRangePickerDialog;
            if(dateRangePickerDialog != null){
              debugPrint("DateRangePickerDialog Instance");
            }
            debugPrint("DateRangePickerDialog Invoked");
          }
          break;
          case DatePickerDateTimeOrder :{
            DatePickerDateTimeOrder datePickerDateTimeOrder = currentWidget as DatePickerDateTimeOrder;
            if(datePickerDateTimeOrder != null){
              debugPrint("DatePickerDateTimeOrder Instance");
            }
            debugPrint("DatePickerDateTimeOrder Invoked");
          }
          break;
          case DatePickerDialog :{
            DatePickerDialog datePickerDialog = currentWidget as DatePickerDialog;
            if(datePickerDialog != null){
              debugPrint("DatePickerDialog Instance");
            }
            debugPrint("DatePickerDialog Invoked");
          }
          break;
          case InputDatePickerFormField :{
            InputDatePickerFormField datePickerDialog = currentWidget as InputDatePickerFormField;
            if(datePickerDialog != null){
              debugPrint("InputDatePickerFormField Instance");
            }
            debugPrint("InputDatePickerFormField Invoked");
          }
          break;
          default:
            debugPrint("Widget type doesn't match!");
        }

      }
      context.visitChildElements((child) {
        _fieldCapture(child);
      });
    }
  }
  void getWidgetPosition(currentContext) async {
    final RenderBox? renderBox = currentContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      x = position.dx.toString();
      y = position.dy.toString();

      debugPrint("X : ${position.dx},y : ${position.dy}");
    }
  }

  findRenderObject(context){
    final renderObject = context.findRenderObject() as RenderBox?;
    // final renderObject = RenderBox.of(context);
    debugPrint("RO: $renderObject");
    GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
      if(event is PointerDownEvent) {
        RenderBox r = context.findRenderObject() as RenderBox;
        BoxHitTestResult hitTestResult = BoxHitTestResult();
        // r.hitTest(hitTestResult, position: event.localPosition);
        for (final result in hitTestResult.path) {
          if (result.target is RenderBox) {
            final targetBox = result.target as RenderBox;
            final targetWidget = targetBox.owner?.rootNode;
            debugPrint("TARGET: ${targetWidget.runtimeType}");
            if (targetWidget is RenderObjectWidget) {
              // Now, targetWidget refers to the widget that was clicked
              debugPrint("Clicked widget: $targetWidget");
              if (targetWidget.runtimeType is IconButton) {
                debugPrint("Clicked widget: $targetWidget");
              } else if (targetWidget is GestureDetector) {
                // Handle event for GestureDetector
                debugPrint("Clicked widget: $targetWidget");
              } else if (targetWidget is ElevatedButton) {
              // Handle event for GestureDetector
              debugPrint("Clicked widget: $targetWidget");
            } else if (targetWidget is Action) {
            // Handle event for GestureDetector
            debugPrint("Clicked widget: $targetWidget");
          } else if (targetWidget is InkWell) {
        // Handle event for GestureDetector
        debugPrint("Clicked widget: $targetWidget");
           }
              break;
            }
          }
        }
        debugPrint("BOXX: $r");
      }
    });

  }
  targetTapEvent(context){

    GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
      if(event is PointerDownEvent) {
        debugPrint("PointerDownEvent called");

        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(event.position);
        // Perform hit testing to find the widget at the local position.
        final widget = findWidgetAtPosition(localPosition, context);
        debugPrint("CLICKED WIDGET: $widget");

        // debugPrint("event.buttons: ${event.buttons}");
        // debugPrint("event.viewId: ${event.viewId}");
        // debugPrint("event.position: ${event.position}");
        // debugPrint("event.transform: ${event.transform}");
        // debugPrint("event.timeStamp: ${event.timeStamp}");
        //
        // debugPrint("event.pointer: ${event.pointer}");
        // debugPrint("event.embedderId: ${event.embedderId}");
        // debugPrint("event.localPosition: ${event.localPosition}");
        // debugPrint("event.device: ${event.device}");
        // debugPrint("event.delta: ${event.delta}");
        //
        // debugPrint("event.transform: ${event.transform}");
        // debugPrint("event.distance: ${event.distance}");
        // debugPrint("event.distanceMax: ${event.distanceMax}");
        // debugPrint("event.distanceMin: ${event.distanceMin}");
        // debugPrint("event.down: ${event.down}");
        //
        // debugPrint("event.kind: ${event.kind}");
        // debugPrint("event.localDelta: ${event.localDelta}");
        // debugPrint("event.obscured: ${event.obscured}");
        // debugPrint("event.orientation: ${event.orientation}");
        // debugPrint("event.original: ${event.original}");
        //
        // debugPrint("event.platformData: ${event.platformData}");
        // debugPrint("event.pressure: ${event.pressure}");
        // debugPrint("event.pressureMax: ${event.pressureMax}");
        // debugPrint("event.pressureMin: ${event.pressureMin}");
        // debugPrint("event.radiusMajor: ${event.radiusMajor}");
        //
        // debugPrint("event.radiusMinor: ${event.radiusMinor}");
        // debugPrint("event.radiusMax: ${event.radiusMax}");
        // debugPrint("event.radiusMin: ${event.radiusMin}");
        // debugPrint("event.size: ${event.size}");
        // debugPrint("event.synthesized: ${event.synthesized}");
        // debugPrint("event.tilt: ${event.tilt}");

        // RenderBox? renderBox = context.findRenderObject() as RenderBox;
        // var result = BoxHitTestResult();
        // renderBox.hitTest(result, position: event.position);
        // // WidgetsBinding.instance.hitTestInView(result, event.position, event.viewId);
        // for (final entry in result.path) {
        //   if (entry.target == renderBox) {
        //     // final MyWidgetState? widget = myWidgetKey.currentState;
        //     // if (widget != null) {
        //     //   final Type widgetType = widget.runtimeType;
        //     //   final GlobalKey widgetKey = myWidgetKey;
        //     //   print("Widget Type: $widgetType, Widget Key: $widgetKey");
        //     // }
        //
        //   }
        // }


        //By using HitTest
        // RenderBox renderBox = context.findRenderObject() as RenderBox;
        // var result = HitTestResult();
        // WidgetsBinding.instance.hitTestInView(result, event.position, event.viewId);
        // debugPrint("result.path: ${result.path}");
        //
        // for (final entry in result.path) {
        //   if (entry.target == renderBox) {
        //     // The widget was clicked
        //     RenderObject renderObject = renderBox;
        //     final renderBoxOwner = renderObject.owner;
        //     if(renderBoxOwner != null) {
        //       final renderObjectWidget = renderBoxOwner.ensureSemantics();
        //       debugPrint("renderObjectWidget: $renderObjectWidget");
        //     }
        //     debugPrint("MyWidget was clicked!: $renderObject");
        //     break;
        //   }
        // }

        // for(var widgetMap in widgetList) {
        //   if(widgetMap.containsKey("category")) {
        //
        //     var category = widgetMap["category"];
        //     // debugPrint("category: $category");
        //     var xPos = widgetMap["left"];
        //     var yPos = widgetMap["top"];
        //     // debugPrint("$xPos $yPos ${event.localPosition.dx} D${event.distanceMax}");
        //     // var c = xPos * yPos;
        //     // if(event.localPosition.dx >= 0 && event.localPosition.dx <= xPos && event.localPosition.dy >= 0 && event.localPosition.dy <= yPos) {
        //     //   if(category == "IconButton") {
        //     //     debugPrint("IconButton listened1");
        //     //   }
        //     // }
        //   }
        // }

      }
    });
  }
  Widget? findWidgetAtPosition(Offset localPosition, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    // Perform hit testing
    final result = BoxHitTestResult();
    // renderBox.hitTest(result, position: localPosition);

    for (final entry in result.path) {
      if (entry.target is RenderBox) {
        final RenderBox targetRenderBox = entry.target as RenderBox;
        // Try to find the widget by traversing the widget tree
        final widget = findWidgetFromRenderBox(targetRenderBox, context);

        if (widget != null) {
          return widget;
        }
      }
    }

    return null;
  }

  Widget? findWidgetFromRenderBox(RenderBox targetRenderBox, BuildContext context) {
    Element? element;

    // Walk up the widget tree until we find the element associated with the RenderBox
    BuildContext? currentContext = context;
    while (currentContext != null) {
      if (currentContext.findRenderObject() == targetRenderBox) {
        element = currentContext as Element;
        break;
      }
      final widget = currentContext.widget;

      if (widget is MaterialApp || widget is Scaffold) {
        debugPrint("Element is MaterialApp || Scaffold");
        break; // You can adjust this to match your widget hierarchy
      }

      currentContext = currentContext.findAncestorWidgetOfExactType<Widget>() as BuildContext?;
    }
    return element?.widget;
  }





  }


@JsonSerializable()
class FieldTrackDataModels {
  @JsonKey(name: 'screenName')
  String? screenName;

  @JsonKey(name: 'identifier')
  String? identifier;

  @JsonKey(name: 'captureType')
  String? captureType;

  @JsonKey(name: 'campaignId')
  String? campaignId;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'markAsGoal')
  bool? markAsGoal;

  @JsonKey(name: 'eventName')
  String? eventName;

  FieldTrackDataModels({
    this.screenName,
    this.identifier,
    this.captureType,
    this.campaignId,
    this.value,
    this.markAsGoal,
    this.eventName,
  });

  factory FieldTrackDataModels.fromMap(Map<dynamic, dynamic> data) {
    return FieldTrackDataModels(
      screenName: data['screenName'],
      identifier: data['identifier'],
      captureType: data['captureType'],
      campaignId: data['campaignId'],
      value: data['value'],
      markAsGoal: data['markAsGoal'],
      eventName: data['eventName'],
    );
  }

}


class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({Key? key,required this.child,required this.message}) : super(key: key, child: child);

  @override
  final Widget child;

  // message variable for
  // our inherited widget
  final String message;

  // static MyInheritedWidget of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  // }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return true;
  }
}











