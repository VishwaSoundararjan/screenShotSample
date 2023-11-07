import 'package:flutter/material.dart';




class TextsCollector extends StatefulWidget {
  @override
  _TextsCollectorState createState() => _TextsCollectorState();
}

class _TextsCollectorState extends State<TextsCollector> {
  List<String> texts = [];

  @override
  Widget build(BuildContext context) {
    final className = context.widget.runtimeType.toString();
    print("Received class Name:: $className");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello'),
          Text('World'),
          ElevatedButton(
            onPressed: () {
              // Collect Texts logic
              traverseWidgetTree(context);
            },
            child: Text('Button - 1'),
          ),
          ElevatedButton(
            onPressed: () {
              // Collect Texts logic
              traverseWidgetTree(context);
            },
            child: Text('Collect Texts'),
          ),
        ],
      ),
    );
  }

  void traverseWidgetTree(BuildContext element) {
    final elements = element as Element;
    final widgetName = element.widget.runtimeType.toString();
    final widgetData = <String, dynamic>{};
    elements.visitChildElements((child) {
      // Perform operations on the current widget
      Widget currentWidget = child.widget;
      if (currentWidget is Text) {
        String? text = currentWidget.data;
        // Perform operations on the text widget
        debugPrint('Text widget1: $text');
      }
      // else if (currentWidget is RichText) {
      //   String? text = currentWidget.text.toPlainText();
      //   print('Text widget2: $text');
      // }
      // ...
      // Recursively traverse child elements
      //traverseWidgetTree(child);
    });
    if (element.widget is Text) {
      final textWidget = element.widget as Text;
      widgetData['data'] = textWidget.data;
    } else if (element.widget is RichText) {

    } else if (element.widget is ElevatedButton) {
      final elevatedButtonWidget = element.widget as ElevatedButton;
      debugPrint('Widget Type: ElevatedButton');
      widgetData['child'] = (elevatedButtonWidget.child as Text).data;
      debugPrint('${(elevatedButtonWidget.child as Text).data}');
      widgetData['onPress'] = elevatedButtonWidget.onPressed;
      debugPrint('${elevatedButtonWidget.onPressed}');
      debugPrint('ButtonLPress :: ${elevatedButtonWidget.onPressed != null ? true : false}');
    }
  else if (element.widget is TextField ) {
      final currentWidget = element.widget as TextField;
      TextEditingController controller = currentWidget.controller!;
      setState(() {
        controller.text="Welcome";
      });
      // Now you have the controller, and you can access its properties or update its value
      debugPrint('TextField controller: $controller');
      debugPrint('Widget Type: TextField');
  }

   // print('Class Name: $widgetName, Widgets Used: $widgetData');

    element.visitChildElements((child) {
      traverseWidgetTree(child);
    });
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   final rootElement = context.findRootAncestorStateOfType<_MyApppState>()!.context;
    //   traverseWidgetTree(rootElement);
    // });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      traverseWidgetTree(context);
    });
  }
}