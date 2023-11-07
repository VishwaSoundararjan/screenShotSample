import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() {
    print("createState");
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  void _increment() {
    setState(() {
      _counter = _counter + 1;
    });
  }
  int _counterr = 0;

  void _incrementCounter() {
    setState(() {
      _counterr++;
    });
  }

  late int _counter;
  @override
  void initState() {
    print("initState");
    _counter = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lifecycle Demo"),
      ),
      body: Container(
          child: Center(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(_counter.toString()),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: _increment, child: const Text("Increment")),
                MyButton(
                  onPressed: _incrementCounter,
                ),
              ],
            ),
          )),
    );
  }
}


class MyButton extends StatefulWidget {
  final VoidCallback onPressed;

  MyButton({required this.onPressed});

  @override
  _MyButtonState createState() => _MyButtonState();
}
class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text('Increment Counter'),
    );
  }

  @override
  void didUpdateWidget(covariant MyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("MyButton widget was updated!");
  }
  @override
  void dispose() {
    // This method is called when the widget is removed from the widget tree.
    print('MyWidget disposed!');
    super.dispose();
  }

  @override
  void deactivate() {
    // This method is called when the widget is deactivated, such as when navigating to another route.
    print('MyWidget deactivated!');
    super.deactivate();
  }
}