import 'package:flutter/material.dart';


class MyHomePage3 extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage3> {
  Widget _content = Text('Sample'); // Initial content

  void replaceWidget() {
    setState(() {
      _content = Semantics(
        label: 'My Accessible Widget',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Replacement Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _content,
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: replaceWidget,
              child: const Text('Replace Widget'),
            ),
          ],
        ),
      ),
    );
  }
}




// class MyView extends StatefulWidget {
//   @override
//   _MyViewState createState() => _MyViewState();
// }
//
// class _MyViewState extends State<MyView> {
//   @override
//   Widget build(BuildContext context) {
//     return Semantics(
//
//       child: GestureDetector(
//         onTap: () {
//           // Handle view clicked event
//           print('The view was clicked!');
//         },
//         onLongPress: () {
//           // Handle view long clicked event
//           print('The view was long clicked!');
//         },
//         child: Container(
//           width: 200,
//           height: 200,
//           color: Colors.blue,
//           child: Center(
//             child: Text(
//               'My View',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         // Handle accessibility tap event
//         print('The view was clicked (via accessibility)!');
//       },
//       onLongPress: () {
//         // Handle accessibility long press event
//         print('The view was long clicked (via accessibility)!');
//       },
//       onScrollLeft: () {
//         // Handle accessibility scroll left event
//         print('The view was scrolled left (via accessibility)!');
//       },
//       onScrollRight: () {
//         // Handle accessibility scroll right event
//         print('The view was scrolled right (via accessibility)!');
//       },
//     );
//   }
// }



class SampleSemantic extends StatelessWidget {
  const SampleSemantic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semantics Example'),
      ),
      body: Center(
        child: Semantics(
          label: 'Button for Accessibility',
          button: true,
          enabled: true,
          onTap: () {
            print('Button pressed!!');
          },
          child: ElevatedButton(
            onPressed: () {
              print('Button pressed!');
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}

class SemanticsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Dynamic Accessibility Event Handling')),
        body: Center(
          child: AccessibilityWrapper(),
        ),
      ),
    );
  }
}

class AccessibilityWrapper extends StatefulWidget {
  @override
  _AccessibilityWrapperState createState() => _AccessibilityWrapperState();
}

class _AccessibilityWrapperState extends State<AccessibilityWrapper> {
  bool isSemanticsEnabled = true;

  void toggleSemantics() {
    setState(() {
      isSemanticsEnabled = !isSemanticsEnabled;
    });
  }

  List<Widget> buildWidgets() {
    if (isSemanticsEnabled) {
      return [
        MyView(
          onTap: () {
            print('The view was clicked (via accessibility)!');
          },
          onLongPress: () {
            print('The view was long clicked (via accessibility)!');
          },
        ),
      ];
    } else {
      return [
        MyView(
          onTap: () {
            print('The view was clicked!');
          },
          onLongPress: () {
            print('The view was long clicked!');
          },
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed:(){
            toggleSemantics();
            debugPrint("Toggle Semantics - Pressed");
          },
          child: const Text('Toggle Semantics'),
        ),
        const SizedBox(height: 20),
        ...buildWidgets(),
        const Text(
          'Hello, Flutter!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textScaleFactor: 1.0,
          textDirection: TextDirection.ltr,
          locale: Locale('en', 'US'),
          strutStyle: StrutStyle(
            fontSize: 24,
            height: 1.5,
          ),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: true,
          ),
        )
      ],
    );
  }
}

class MyView extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  MyView({
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'My View',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

        ),
      ),
    );
  }
}

