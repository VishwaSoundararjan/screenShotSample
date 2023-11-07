import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({super.key});
  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}
const methodChannel = MethodChannel("flutteraccessibility-channel");

class _MyHomePageState extends State<MyHomePage2> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // This callback will be called after the widget tree has been built
      traverseWidgets(context);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("FlutterAD"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(maxHeight: 100), // Set a maximum height
            //   child: const AndroidView(
            //     viewType: 'native_button',
            //   ),
            // ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: (){
              print("button onpress");
              //traverseWidgets(context);

            }, child: Text('Sample')),
            // Semantics(
            //   label: 'Custom Button',
            //   button: true,
            //   onTap: () {
            //     print('Button tapped');
            //   },
            //   child: ElevatedButton(
            //     onPressed: () {
            //       print('Button pressed');
            //     },
            //     child: const Text('Custom Button'),
            //   ),
            // )
            const TextField(

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _callNativeMethod() async {
    const platform = MethodChannel('flutteraccessibility-channel');
    try {
      await platform.invokeMethod('locationUpdate', {'lat': 12.345, 'lang': 67.890});
    } on PlatformException catch (e) {
      // Handle error
    }
  }

  void traverseWidgets(BuildContext context) {
    final currentWidget = context.widget;
    Widget updatedWidget = currentWidget;
    // Wrap the current widget with gesture handlers
    if (currentWidget is ElevatedButton || currentWidget is TextField) {
      updatedWidget = Semantics(

        button: true,
        onTap: () {
          print('Widget tapped');
        },
        child: ElevatedButton(
          onPressed: () {
            print('Button pressed');
          },
          child: const Text('Custom Button'),
        ),
      );
    }
    // Perform operations on the current widget
    switch (currentWidget.runtimeType) {
      case Text:
        print("TEXT");
        break;
      case ElevatedButton:
        print("ELEVATEDBUTTON");
        {
          final elevatedButton = context.widget as ElevatedButton;
         ElevatedButton elevatedBtn = elevatedButton;

        }
        break;
      case TextField:
        print("TEXTFIELD");
        break;
      case Image:
        print("IMAGE");
        break;
      default:
        break;
    }
    final element = context as Element;
    element.visitChildren((child) {
      traverseWidgets(child);
    });
  }
}
