import 'package:flutter/material.dart';

import '../sample_page.dart';


class App extends StatelessWidget {
  static final RouteObserver<PageRoute> routeObserver =
  RouteObserver<PageRoute>();

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      navigatorObservers: [routeObserver],
      routes: {
        '/': (context) => Screen1(),
        'screen2': (context) => Screen2(),
      },
    );
  }
}

class ScreenWrapper extends StatefulWidget {
  final Widget child;
  final Function() onLeaveScreen;
  final String routeName;
  const ScreenWrapper({super.key, required this.child, required this.onLeaveScreen, required this.routeName});

  @override
  State<StatefulWidget> createState() {
    return ScreenWrapperState();
  }
}

class ScreenWrapperState extends State<ScreenWrapper> with RouteAware {

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void onLeaveScreen() {
    if (widget.onLeaveScreen != null) {
      widget.onLeaveScreen();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    App.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    super.dispose();
    App.routeObserver.unsubscribe(this);
  }

  @override
  void didPush() {
    print('*** Entering screen: ${widget.routeName}');
  }

  void didPushNext() {
    print('*** Leaving screen: ${widget.routeName}');
    onLeaveScreen();
  }

  @override
  void didPop() {
    print('*** Going back, leaving screen: ${widget.routeName}');
    onLeaveScreen();
  }

  @override
  void didPopNext() {
    print('*** Going back to screen: ${widget.routeName}');
  }

}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      onLeaveScreen: () {
        print("***** Here's my special handling for leaving screen1!!");
      },
      routeName: '/',
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const Text('This is Screen1'),
              ElevatedButton(
                child: const Text('Press here to go to screen 2'),
                onPressed: () {
                  Navigator.pushNamed(context, 'screen2');
                },
              ),
              ElevatedButton(
                child: const Text(
                    "Press here to go back (only works if you've pushed before)"),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              const Expanded(child: MyHomePage(title: "Date Picker"))
            ],
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      routeName: 'screen2',
      onLeaveScreen: () {  },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              const Text('This is Screen2'),
              ElevatedButton(
                child: const Text('Press here to go to screen 1'),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              ElevatedButton(
                child: const Text(
                    "Press here to go back (only works if you've pushed before)"),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}