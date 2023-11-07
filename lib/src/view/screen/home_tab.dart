import 'dart:async';

import 'package:screenshotsample/src/data/service/product_service.dart';
import 'package:screenshotsample/src/view/screen/component/hometab/body_page.dart';
import 'package:screenshotsample/src/view/screen/component/hometab/header_page.dart';
import 'package:screenshotsample/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../traverse_widgets (3).dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});


  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    debugPrint('Screenshot taken, path: $path');
    methodChannel.invokeMethod('passScreenshotData',path);
  }

  updateViewJson() async {
    List<Map<String,dynamic>> fieldTrackingData = await TraverseClass().traverseWidgetTree(context);//updateViewsJson
    methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
    //print("$fieldTrackingData");
  }
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const oneSec = Duration(seconds: 2);
    _timer=  Timer.periodic(oneSec, (Timer timer) async {
      // This statement will be printed after every one second
      // takeScreenshotMethod();
      // updateViewJson();
    });
    TraverseClass.initiate(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 5,
            ),
            HeaderPage(),
            const SizedBox(
              height: 20,
            ),
            const BodyPage(
            ),
          ],
        ),
      ),
    );
  }
}
