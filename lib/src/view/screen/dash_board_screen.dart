import 'dart:async';
import 'package:screenshotsample/src/const/app_colors.dart';
import 'package:screenshotsample/src/view/screen/cart_tab.dart';
import 'package:screenshotsample/src/view/screen/category_tab.dart';
import 'package:screenshotsample/src/view/screen/favorite_tab.dart';
import 'package:screenshotsample/src/view/screen/personal_tab.dart';

import 'package:screenshotsample/src/viewmodel/bottom_navigate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../screenTracking.dart';
import 'home_tab.dart';
import '../../../traverse_widgets (3).dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Widget> page = [
    HomeTab(),
    const CategoryTab(),
    CartTab(),
    FavoriteTab(),
    PersonalTab(),
  ];
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
    var bottomProvider =
        Provider.of<BottomNavigationProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: page[bottomProvider.currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.primaryColorGray,
          selectedItemColor: AppColors.primaryColorRed,
          currentIndex: bottomProvider.currentIndex,
          onTap: (int index) {
            bottomProvider.changePageTab = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: bottomProvider.currentIndex != 0
                  ? SvgPicture.asset('assets/images/home_inactive.svg')
                  : SvgPicture.asset('assets/images/home_active.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: bottomProvider.currentIndex != 1
                  ? SvgPicture.asset('assets/images/categories_inactive.svg')
                  : SvgPicture.asset('assets/images/categories_active.svg'),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: bottomProvider.currentIndex != 2
                  ? SvgPicture.asset('assets/images/bag_inactive.svg')
                  : SvgPicture.asset('assets/images/bag_active.svg'),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: bottomProvider.currentIndex != 3
                  ? SvgPicture.asset('assets/images/hear_inactive.svg')
                  : SvgPicture.asset('assets/images/hear_active.svg'),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: bottomProvider.currentIndex != 4
                  ? SvgPicture.asset('assets/images/profile_inactive.svg')
                  : SvgPicture.asset('assets/images/profile_active.svg'),
              label: 'Personal',
            ),
          ],
        ),
      ),
    );
  }
}
