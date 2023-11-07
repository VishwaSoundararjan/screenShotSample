import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshotsample/action_sample.dart';
import 'package:screenshotsample/traverse_widgets%20(1).dart';
import 'package:screenshotsample/traverse_widgets%20(2).dart';
import 'package:screenshotsample/traverse_widgets%20(3).dart';
import 'package:screenshotsample/widgetLifecycle.dart';
import 'Navigation/navigationObserver1.dart';
import 'fieldCapture.dart';
import 'main.dart';


class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  var key1 = GlobalKey();
  var key2 = const ValueKey<String>("my btn");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
    });
  }
  updateViewJson() async {
    List<Map<String,dynamic>> fieldTrackingData = await TraverseClass().traverseWidgetTree(context);//updateViewsJson
    methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
    //print("$fieldTrackingData");
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("key1:${key1.toString()}, key2::${key2.toString()}");
    debugPrint("ky1 :: ${key1.runtimeType.toString()}");
    debugPrint("ky1 :: ${key1.toString()}");
    WidgetsBinding.instance?.addPostFrameCallback((_) {

    });
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 100,
            // ),
            // IconButton(
            //     onPressed: (){
            //        //FieldCapture().fieldCapture(context);
            //       TraverseClass().traverseWidgetTree(context);
            //     },
            //     icon: const Icon(Icons.send_and_archive,color: Colors.red,)
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   key: key1,
            //     onPressed: (){
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const App()));//To check navigation observer
            //     },
            //     child: const Text("Btn-1")
            // ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              key:key2,
              onTap: ()  {
                // FieldCapture().fieldCapture(context);
              updateViewJson();
              },
              // child:  Image.asset("assets/images/tech.jpg",height: 200,width: 200,),
              child:  Text("Click here"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10,right: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                 "https://cafefcdn.com/thumb_w/650/2019/6/4/5069g-3x2-forever-in-florals-768x512-1559636365541203324963-crop-15596363709051973797845.jpg",
                  fit: BoxFit.cover,
                  width: 160,
                  height: 180,
                ),
              ),
            ),
            // const ActionsExample(),
            // const Expanded(child: MyHomePage(title: "Date Picker")),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const DashBoard()));
            //   },
            //   child: const Text('Custom Bottom Bar'),
            // ),
          ],
        ),
      ),
    // floatingActionButton: FloatingActionButton(
    //     onPressed: (){
    //       FieldCapture().fieldCapture(context);
    //     },
    //     child: const Icon(Icons.find_in_page)
    // ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select date'),
            ),

            //_selectDate(context);
          ],
        ),
      ),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  double screenWidth = 0 ;
  double screenHeight = 0 ;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
     TraverseClass().traverseWidgetTree(context);
    });
    return  Scaffold(
      appBar:AppBar(
        title: const Text("Dashboard"),
      ),
          body: Stack(
            children: [
              SingleChildScrollView(
        child: Column(
              children: [
                Image.asset("assets/images/glass.jpg",
                  height: screenHeight/2,
                  width: screenWidth,),
                Image.asset("assets/images/clothes-1.jpg",
                  height: screenHeight/2,
                  width: screenWidth,),
                Image.asset("assets/images/perfume.jpg",
                  height: screenHeight/2,
                  width: screenWidth,),
                Image.asset("assets/images/tech.jpg",
                  height: screenHeight/2,
                  width: screenWidth,),
              ],

        ),
    ),
               Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  const EdgeInsets.only(bottom: kIsWeb ? 20 : 0),
                  child: _buildBottomBar()
                ),
              ),
              // Positioned(
              //   child: SizedBox(
              //     height: 50,
              //     width: 50,
              //     child: Container(
              //       color: Colors.red,
              //     ),
              //   ),
              // )
            ],
          ),

    );
  }
  Widget _buildBottomBar(){
    int currentIndex = 0;
    return CustomAnimatedBottomBar(
        containerHeight: 70,
        containerWidth: kIsWeb ? screenWidth /2 : double.maxFinite,
        backgroundColor: Colors.black,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => currentIndex = index);
        },

        items: <BottomNavyBarItem>[
    BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: Text('Home'),
    activeColor: Colors.green,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    icon: Icon(Icons.people),
    title: Text('Users'),
    activeColor: Colors.purpleAccent,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    icon: Icon(Icons.message),
    title: Text(
    'Messages ',
    ),
    activeColor: Colors.pink,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    icon: Icon(Icons.settings),
    title: Text('Settings'),
    activeColor: Colors.blue,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
    ),
    ], borderRadius: kIsWeb ? 30 : 0,
    );
  }
}




class CustomAnimatedBottomBar extends StatelessWidget {

  CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear, required this.containerWidth, required this.borderRadius,
  }) : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final double containerWidth;
  final double borderRadius ;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: SafeArea(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
          isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor == null
                        ? item.activeColor
                        : item.inactiveColor,
                  ),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class BottomNavyBarItem {

  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;

}

