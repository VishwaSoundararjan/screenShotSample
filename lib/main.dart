import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:screenshotsample/Navigation/re_navigation_observer.dart';
import 'package:screenshotsample/accessibility2.dart';
import 'package:screenshotsample/acessibilityservices.dart';
import 'package:screenshotsample/sampleInheritedWidget.dart';
import 'package:screenshotsample/sample_page.dart';
import 'dart:io';

import 'package:screenshotsample/second.dart';
import 'package:screenshotsample/semantics.dart';
import 'package:screenshotsample/semantics1.dart';
import 'package:screenshotsample/src/router/routerr.dart';
import 'package:screenshotsample/src/view/screen/dash_board_screen.dart';
import 'package:screenshotsample/src/viewmodel/address_viewmodel.dart';
import 'package:screenshotsample/src/viewmodel/auth_viemodel.dart';
import 'package:screenshotsample/src/viewmodel/bottom_navigate_provider.dart';
import 'package:screenshotsample/src/viewmodel/cart_viewmodel.dart';
import 'package:screenshotsample/src/viewmodel/product_viewmodel.dart';
import 'package:screenshotsample/widgetLifecycle.dart';
import 'accessibility.dart';
import 'accessibility1.dart';
import 'accessibility_plugin.dart';
import 'fieldCapture.dart';
import 'focus_node.dart';
import 'forms.dart';
import 'screenTracking.dart';
import 'package:provider/provider.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:provider/provider.dart';

// void main() {
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => MyState(),
//       child: const MyAppp(), //AccessibilityPlugin
//       //child: const FocusExampleApp()
//       // child: const AccessibilityPlugin(),
//     ),
//   );
// }


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_)=> CartViewModel()),
        ChangeNotifierProvider(create: (_)=> AddressViewModel()),
        ChangeNotifierProvider(create: (_)=> ProductViewModel()..getListProduct()),
        ChangeNotifierProvider(create: (_)=>AuthViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routerr.onGenerateRouter,
        home: DashBoardScreen(),
      ),
    );
  }
}



String generateRandomString() {
  final Random random = Random();
  // Generate 3 random characters
  final characters = List.generate(3, (_) {
    final int charCode = random.nextInt(26) + 65; // Random uppercase letter (A-Z)
    return String.fromCharCode(charCode);
  });

  // Generate 3 random digits
  final digits = List.generate(3, (_) {
    final int digit = random.nextInt(10); // Random digit (0-9)
    return digit.toString();
  });

  // Shuffle the characters and digits
  final List<String> combinedList = [...characters, ...digits]..shuffle(random);

  // Join the shuffled list to create the final random string
  final String randomString = combinedList.join();

  return randomString;
}
var key = const ValueKey("my-btn1");
TextEditingController? statesControllers = TextEditingController();
MaterialStatesController btnStateController = MaterialStatesController();
// extension Bar on ButtonStyleButton {
//   id()  {
//     final id =ValueKey(generateRandomString());
//     return key;
//   }
//   customListeners(){
//
//     MaterialStatesController btnStateController = MaterialStatesController();
//   }
// }
// extension TextBar on TextField {
//   ctrl()  {
//     return TextEditingController();
//   }
// }


class MyState extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyState myState = Provider.of<MyState>(context);

    return Text('Counter: ${myState.counter}');
  }
}
class MyAppp extends StatefulWidget {
  const MyAppp({Key? key}) : super(key: key);

  @override
  State<MyAppp> createState() => _MyApppState();
}
const methodChannel = MethodChannel('samples.flutter.dev');
class _MyApppState extends State<MyAppp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vision Education',
      navigatorObservers: [],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        routes: {
          "/Career": (BuildContext ctx) => const Career(),
          "/Certification": (BuildContext ctx) => const Certification(),
          "/DashboardPage" : (BuildContext ctx)  => const DashboardPage(title: "Vision Education")
        },
      //initialRoute: '/DashboardPage',
      //home: const DashboardPage(title: "Vision Education"),
      // home: MyHomePage1()
        //home: const Myapp()
      // home: const SamplePage(),
      home: const MyTree(),
        //home: const MyPage()
      //   home: MyHomePage3()
        //home: const SampleSemantic()
      // navigatorObservers: [
      //   ReFlutterNavigatorObserver(),
      // ],
    );
  }
}
class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserForm(),
      //   body: TextsCollector()
    );
  }
}


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required String title}) : super(key: key);

  @override
  State<DashboardPage> createState() => DashboardPageState();
}


class DashboardPageState extends State<DashboardPage> {

  late var navigationParameter;
  late var screenName;
  late var receivedData;
  Timer? _timer;

  var btnKey1=GlobalKey();
  var btnKey2=GlobalKey();
  var btnKey3=GlobalKey();
  var btnKey4=GlobalKey();
  var btnKey5=GlobalKey();
  var btnKey6=GlobalKey();
  var imgKey7=GlobalKey();

  deeplinkHandler(){

  }

  screenNavigator(var screenName,var data){
    switch(screenName){

      case "Carrier":{
        if(data!=null){

          Navigator.pushNamed(context, '/Carrier',arguments: data,);
        }
        else {
          Navigator.pushNamed(context, '/Carrier');
        }
        break;
      }
      case "Certification":{

        if(data!=null){
          Navigator.pushNamed(context, '/Certification',arguments: data);
        }
        else
          Navigator.pushNamed(context, '/Certification');
        break;
      }

      default:{
        print("ScreenName is not defined!!!");
      }
    }

  }


  initializeSharedPreference() async {
    deeplinkHandler();
  }

var textController = TextEditingController();
  @override
  initState(){
    super.initState();
    initializeSharedPreference();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
          debugPrint("WidgetBinding form Initstate");
    });
    // takeScreenshotMethod();
  }
  sdkRegisteration() {

    Map userData = {
      "userUniqueId":"1111",
      "name": "kkkkk",
      "age":"23",
      "email": "abc@gmail.com",
      "phone": "12334455",
      "gender": "Male",
      "profileUrl":"",
      "dob":"23/12/2010",
      "education":"BE",
      "employed":"true",
      "married":"false",
      "deviceToken":"djwojioejij398ioed9",
      "storeId":"555"
    };
    methodChannel.invokeMethod('sdkRegisteration',userData);
  }
  void takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
                                debugPrint('Screenshot taken, path: $path');
                                methodChannel.invokeMethod('passScreenshotData',path);
  }

updateViewJson() async {
  List<Map<String,dynamic>> fieldTrackingData = await ScreenTracking().traverseWidgetTree(context);//updateViewsJson
  methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
  //print("$fieldTrackingData");
}



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // final Future<dynamic> arrayList = methodChannel.invokeMethod('getFieldTrackList');
      //fetchData();
      debugPrint("WidgetBinding form Build");
    });


   //  const oneSec = Duration(seconds: 2);
   //  _timer=  Timer.periodic(oneSec, (Timer timer) async {
   // // This statement will be printed after every one second
   //    takeScreenshotMethod();
   //    updateViewJson();
   //  });

    Future<bool> _onWillPop() async {
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child:Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text("Vision Education"),
                Container(
                  color: Colors.transparent,
                  child:  const SizedBox(
                    height: 20,
                    width: 135,
                  ),
                ),
                Stack(
                  children: [
                    GestureDetector(
                        onTap: (){

                        },
                        child:const Icon(Icons.notifications,)
                    ),
                  ],
                )

              ],),
            backgroundColor: Colors.indigo,
            automaticallyImplyLeading: false,

          ),
          body:Container(
            child: (
                SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child:Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0,0,0,0),
                            height: 250,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                              color: Colors.black,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0,0.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child:Column(
                              children: [
                                Padding(
                                  padding:EdgeInsets.fromLTRB(0,40,0,0),
                                  child: CircleAvatar(
                                      key: imgKey7,
                                      radius:40.2,
                                      backgroundColor: Colors.white,
                                      child:Icon(Icons.account_circle_outlined,size: 70,)
                                  ),
                                ),
                                Padding(
                                    padding:EdgeInsets.fromLTRB(0,10,0,0),
                                    child:Column(
                                      children: const [
                                        Text("Vision User",style: TextStyle(color:Colors.white,fontSize: 20.2),),
                                        // Text(shared.getString("userId").toString(),style: TextStyle(color:Colors.white,fontSize: 20.2))
                                      ],
                                    )
                                )

                              ],
                            ) ,
                          ),
                          Padding(
                            padding:EdgeInsets.fromLTRB(20,10,20,10),

                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                key: btnKey1,
                                onPressed: () async {
                                //_refluttersdkPlugin.locationUpdate(13.0827, 80.2707);
                                  sdkRegisteration();
                                methodChannel.invokeMapMethod('locationUpdate', {'lat': 13.0827, 'lang': 80.2707 });
                              }, child: const Text("Sdk-Reg & loc"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),
                            child: Container(
                              width: double.maxFinite,
                              child:const TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter text here",
                                  border: OutlineInputBorder(
                                  )
                                ),
                              )
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.fromLTRB(20,10,20,10),

                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                key: btnKey2,onPressed: ()
                              {

                                if (kIsWeb) {
                                  //_refluttersdkPlugin.customEvent("Payment");

                                  var data = { 'eventName': 'Website Open', 'eventData': 'Viewed Groceries', 'pId':123, 	};
                                  methodChannel.invokeMethod('customEvent',data);
                                  //	_refluttersdkPlugin.customEventWithData(data);
                                }
                                else{
                                  var eventData = {
                                    "name": "payment",
                                    "data": {"id": "6744", "price": "477"}
                                  };
                                  // _refluttersdkPlugin.customEventWithData(eventData);
                                }



                              }, child: Text("Custom event"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                key: btnKey3,onPressed: () {
                                // _refluttersdkPlugin.appConversion();
                              }, child: const Text("App conversation tracking"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),
                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                key: btnKey4,onPressed: () async {
                                String? path = await FlutterNativeScreenshot.takeScreenshot();
                                debugPrint('Screenshot taken, path: $path');
                                if (path == null || path.isEmpty) {
                                  print('Error taking the screenshot :(');
                                  return;
                                } // if error
                                print('The screenshot has been saved to: $path');
                                File imgFile = File(path);
                                Uint8List imageBytes = imgFile.readAsBytesSync();
                                String base64String = base64Encode(imageBytes);
                                methodChannel.invokeMethod('passScreenshotData',base64String);


                                // Navigator.pushReplacement(context,
                                //     MaterialPageRoute(builder: (context) => const Certification()));
                              }, child: const Text("TakeScreenShot"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),

                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _timer?.cancel();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const UserForm()));
                              //  Navigator.of(context).pushNamed('/Carrier?resulid=OCtMHxLM218V058UF9ENEMyOTY5QXwxSg==&utm_source=SmartDx&utm_medium=wp&utm_campaign=RH_WEB_ET_CHECK_K3m');
                              }, child: Text("User Forms"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),

                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _timer?.cancel();
                                  // Navigator.pushNamed(context, '/Career');
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => const Career()));
                                  //  Navigator.of(context).pushNamed('/Carrier?resulid=OCtMHxLM218V058UF9ENEMyOTY5QXwxSg==&utm_source=SmartDx&utm_medium=wp&utm_campaign=RH_WEB_ET_CHECK_K3m');
                                }, child: Text("Career Page"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),
                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _timer?.cancel();
                                  Navigator.pushNamed(context, '/Certification');
                                  //  Navigator.of(context).pushNamed('/Carrier?resulid=OCtMHxLM218V058UF9ENEMyOTY5QXwxSg==&utm_source=SmartDx&utm_medium=wp&utm_campaign=RH_WEB_ET_CHECK_K3m');
                                }, child: Text("Certification Page"),

                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(20,10,20,10),
                            child: Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                key: btnKey6,
                                onPressed: () async {
                                }, child: const Text("Notification list"),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),



      ),
    );
  }
}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
///////////////////////////////////////////////


class Certification extends StatelessWidget {
  const Certification({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
          child: Container(
            child: const Text("Certification Page"),
          ),
        ),
      );
  }
}

class Career extends StatelessWidget {
  const Career({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          child: const Text("Career Page"),
        ),
      ),
    );
  }
}
