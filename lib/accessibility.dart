import 'package:flutter/material.dart';



class MyHomePage1 extends StatelessWidget {
  const MyHomePage1({super.key});

  void _onButtonClicked(BuildContext context) {

  traverseWidgetTree(context);    // Perform specific actions for the clicked button
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Buttons Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _onButtonClicked(context),
              child: const Text('Button 1'),
            ),
            ElevatedButton(
              onPressed: () => _onButtonClicked(context),
              child: const Text('Button 2'),
            ),
          ],
        ),
      ),
    );
  }
}
 traverseWidgetTree(BuildContext context) {
  _traverseWidget(context);
}
_traverseWidget(BuildContext context) {
  Widget currentWidget = context.widget;

  switch (currentWidget.runtimeType) {
  case ElevatedButton:{
    final button = context.widget as ElevatedButton;
    final buttonText = button.child as Text;
    // var btn= button.;
    // print("Button '${buttonText.data}'");
  }
  break;
  }
  final element = context as Element;
  element.visitChildren((child) {
    _traverseWidget(child);
  });
}