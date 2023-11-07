import 'dart:ui';

import 'package:flutter/material.dart';


late String currentWidgetKey;
late var cfData;
late double left;
late double top;
late double height;
late double width;


var contentInjectionData = {
  "contentInjection": [
    {
      "activityName": "UserForm",
      "fragementName": "",
      "contentId": "1",
      "contentFields": [
        {
          "left": "15.0",
          "top": "100.0",
          "viewId": "[GlobalKey#0184b]",
          "viewType": "TextField",
          "value": "Hari"
        },
        {
          "left": "15.0",
          "top": "168.0",
          "viewId": "[GlobalKey#0918e]",
          "viewType": "TextField",
          "value": "9876543211"
        },
        {
          "left": "96.36363636363637",
          "top": "402.0",
          "viewId": "[GlobalKey#c0c9b]",
          "viewType": "Image",
          "value": "https://cdn.resulticks.com//Uploads/Campaigns/mpush/50e20e56-50c5-4a5e-967c-0013e3bcf9d1.PNG"
        }
      ]
    }
  ]
};

void contentInjection(BuildContext context) {
  if(context.widget.runtimeType.toString() == contentInjectionData["contentInjection"]![0]["activityName"]){
   var  contentFields = contentInjectionData["contentInjection"]![0]["contentFields"] as List;
    for(cfData in contentFields){
      _contentInjection(context);
    }
  }
}
_contentInjection(BuildContext context){
  final currentWidget = context.widget;
  getWidgetKey(currentWidget);
    // Perform operations on the current widget
    switch (currentWidget.runtimeType) {
      case Text:{
        if(currentWidgetKey == cfData["viewId"]){

        }
      }
      break;
      case ElevatedButton:{
        //if(currentWidgetKey == cfData["viewId"]){
           var elevatedButtonWidget = context.widget as ElevatedButton;
             // MaterialStatesController? materialStatesController = elevatedButtonWidget.statesController;
             // materialStatesController?.addListener((data) {print("Button called from sdk"); } as VoidCallback);
           // VoidCallback? onPressed =elevatedButtonWidget.onPressed;
           // onPressed = () {
           //   print("Button pressed_callback");
           //   // Your custom logic here
           // };
           // Widget wrappedButton = GestureDetector(
           //   onTap: () {
           //     // Your onTap callback logic here
           //     print('Button pressed_callback');
           //   },
           //   child: elevatedButtonWidget,
           // );
           if (elevatedButtonWidget.onPressed != null) {
             debugPrint('ElevatedButton is pressed-sdk');
             // You can also execute the onPressed callback if needed
             elevatedButtonWidget.onPressed!();
           }

        //debugPrint('${(elevatedButtonWidget.child as Text).data}');
           // debugPrint('${elevatedButtonWidget.onPressed}');

      }
      break;
      case TextField:{
        getWidgetPosition(context);
        if(left.toString() == cfData["left"] && top.toString() == cfData["top"] && cfData["viewType"] == "TextField" ){
          final currentWidget = context.widget as TextField;
          TextEditingController controller = currentWidget.controller!;
          controller.text= cfData["value"];
        }
      }
      break;
      case Image:{
       debugPrint("Image positions");
       final currentWidget = context.widget as Image;
       // Replace the image source URL with a new URL
       Image newImage = Image.network('https://new-image-url.com');
       getWidgetPosition(context);
      }
      break;
      default: debugPrint("Widget type doesn't match!");
    }


  final element = context as Element;
  element.visitChildren((child) {
    _contentInjection(child);
  });
}

void getWidgetKey(currentWidget){
  if(currentWidget.key != null){
    //print("key:${currentWidget.key.toString()}");
    currentWidgetKey=currentWidget.key.toString();
  }
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
    print("left: $left,Top: $top, height: $height, width: $width");
  }
}

class ButtonCallback {
  final void Function() onPressed;

  ButtonCallback({required this.onPressed});
}

// Step 2: Create an InheritedWidget
class ButtonCallbackProvider extends InheritedWidget {
  final ButtonCallback buttonCallback;

  ButtonCallbackProvider({
    required this.buttonCallback,
    required Widget child,
  }) : super(child: child);

  static ButtonCallbackProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ButtonCallbackProvider>();
  }

  @override
  bool updateShouldNotify(covariant ButtonCallbackProvider oldWidget) {
    return buttonCallback != oldWidget.buttonCallback;
  }
}

