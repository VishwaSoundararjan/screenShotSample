import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:screenshotsample/contentInjection.dart';
import 'package:screenshotsample/fieldCapture.dart';
import 'package:screenshotsample/screenTracking.dart';
import 'package:screenshotsample/widgetLifecycle.dart';
import 'package:provider/provider.dart';
import 'action_sample.dart';
import 'flutter_native_accssibility.dart';
import 'main.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  UserFormState createState() => UserFormState();
}
enum BestTutorSite { javatpoint, w3schools, tutorialandexample }
class UserFormState extends State<UserForm> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  var nameController = TextEditingController();
  var mobileNoController = TextEditingController();
  var emailIdController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  MaterialStatesController btnController = MaterialStatesController();
  String text = "";
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode btnFocusNode1 = FocusNode();
  FocusNode btnFocusNode2 = FocusNode();
  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  RegExp digitValidator  = RegExp("[0-9]+");
  var isANumber = "";


  Timer? _timer;
  var btnKey1 = const ValueKey<String>("Btn1");
  var btnKey2 = const ValueKey<String>("Btn2");
  var nameFieldKey = const ValueKey<String>("NamefieldKey");
  var mobileNoFieldKey = GlobalKey();
  var emailIdFieldKey = GlobalKey();
  bool value = false;
  bool light = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myListener(){
      debugPrint("UserDefined Listener");
    }
    btnController.addListener(myListener);
  }
  void setValidator(valid){
    setState(() {
      isANumber = valid;
    });
  }
  scrollToCursor(String textFieldValue) {
    final isLonger = textFieldValue.length > text.length;
    text = textFieldValue;
    if (isLonger) _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
  updateViewJson() async {
    List<Map<String,dynamic>> fieldTrackingData = await ScreenTracking().traverseWidgetTree(context);//updateViewsJson
    methodChannel.invokeMethod('updateViewsJson',fieldTrackingData);
    //print("$fieldTrackingData");
  }
  void takeScreenshotMethod() async{
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    //debugPrint('Screenshot taken, path: $path');
    methodChannel.invokeMethod('passScreenshotData',path);
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {

   // contentInjection(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // const oneSec = Duration(seconds: 2);
      // _timer = Timer.periodic(oneSec, (Timer timer) async {
      //   takeScreenshotMethod();
      //   updateViewJson();
      // });
    });

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text("Field Tracking"),
          onTap:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPage()));
    }
      ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              children: [
                 const SizedBox(height: 40,),
                //  TextField(
                //    // clipBehavior: Clip.antiAlias,
                //    //dragStartBehavior: DragStartBehavior.start ,
                //     //key:nameFieldKey,
                //   decoration:  InputDecoration(
                //       icon: const Icon(Icons.print),
                //     suffix: const CircularProgressIndicator(color: Colors.red),
                //       filled: true,
                //       fillColor: Colors.blueAccent,
                //       hintText: "Enter name",
                //       hintStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                //       helperText: "FullName",
                //       errorText: isANumber == "" ? "Please enter Name" : null,
                //       errorStyle: const TextStyle(color: Colors.purpleAccent),
                //       focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.purpleAccent)),
                //       errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                //   ),
                //   //controller: nameController,
                //    onTap:(){
                //     debugPrint("User Tapped TextField");
                //    },
                //    onEditingComplete: (){
                //     debugPrint("Text Editing Completed");
                //    },
                //    onSubmitted: (data){
                //
                //       nameController.clear();
                //     debugPrint("Text field data onSubmitted :: $data");
                //    },
                //    scrollController: ScrollController(),
                //    onChanged: (inputValue){
                //      //scrollToCursor(inputValue);
                //      // if(inputValue.isEmpty || digitValidator.hasMatch(inputValue)){
                //      //   setValidator(inputValue);
                //      // } else{
                //      //   setValidator(inputValue);
                //      // }
                //    },
                //    keyboardType: TextInputType.name,
                //    textInputAction: TextInputAction.send,
                //    textCapitalization: TextCapitalization.words,
                //    textAlign: TextAlign.start,
                //
                //    autocorrect: true,
                //    maxLines: 1,
                //    //maxLength: 10,
                //    // obscureText: true,
                //     obscuringCharacter: "*",
                //    autofocus: true,
                //    focusNode: nodeOne,
                //    cursorColor: Colors.red,
                //    cursorRadius: const Radius.circular(5.0),
                //    cursorWidth: 2.0,
                //    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                //    inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]+"))],
                //  ),
                // const SizedBox(height: 20,),
               const  Text("Awesome Flutter"),
                // Form(
                //   //key: _formKey,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       TextFormField(
                //         key: ValueKey<String>('TextFormFieldKey'),
                //         // The validator receives the text that the user has entered.
                //         validator: (value) {
                //           if (value == null || value.isEmpty) {
                //             return 'Please enter some text';
                //           }
                //           return null;
                //         },
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 16),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             // Validate returns true if the form is valid, or false otherwise.
                //           },
                //           child: const Text('Submit'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // TextField(
                //   key:emailIdFieldKey,
                //   decoration: const InputDecoration(hintText: "Enter Email"),
                //  //controller: emailIdController,
                //   onSubmitted: (data){
                //     print("Text field value is :: $data");
                //   },
                //   focusNode: nodeTwo,
                // ),
                //
                // const SizedBox(height: 20,),
                // ElevatedButton(
                //   key: btnKey1,
                //    //statesController: btnController,
                //   focusNode: btnFocusNode1,
                //   onPressed: () {
                //     debugPrint("normal btn press");
                //     // traverseWidgetTree(context);
                //     //contentInjection(context);
                //     // print("$nameFieldKey,$mobileNoFieldKey,$emailIdFieldKey,");
                //   },
                //   child: const Text('Next Field'),
                // ),
                // TextButton(onPressed: (){}, child: Text("Hello")),
                OutlinedButton(
                    onPressed: () {  },
                    child: const Text("Outlined-btn")
                ),
                IconButton(
                  onPressed: (){debugPrint("Icon button pressed");},
                  icon: const Icon(Icons.access_alarms_outlined),
                ),
                // ElevatedButton(
                //   key: btnKey2,
                //   focusNode: btnFocusNode2,
                //   style: ButtonStyle(
                //       elevation: MaterialStateProperty.all(20),
                //       shadowColor: MaterialStateProperty.all(Colors.transparent)
                //   ),
                //   onLongPress:(){
                //     debugPrint("submit Button long pressed");
                //   },
                //   clipBehavior: Clip.antiAlias,
                //   onFocusChange: (focusFlag){
                //     debugPrint("Button Focus Status :: $focusFlag");
                //   },
                //   onHover:(hover){
                //     debugPrint("Button Hover status :: $hover");
                //   },
                //   autofocus: true,
                //    //statesController: MaterialStatesController(),
                //   onPressed: () {
                //     debugPrint("Submit Button pressed");
                //     // startTextChangeListener();
                //   },
                //   child: const Text('Submit'),
                // ),

                InkWell(
                //  key:const ValueKey<String>("InkWell"),
                  onTap: (){
                    //FieldCapture().fieldCapture(context);
                    debugPrint("Inkwell-pressed");
                  },
                    // statesController:  MaterialStatesController(),
                    focusNode: FocusNode(),
                  child: const Text("Inkwell-Button")
                ),

                // ElevatedButton(onPressed: (){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const ActionListenerDemo()));
                // }, child: const Text("Action Listener")),
                // Switch(
                //   // This bool value toggles the switch.
                //value: light,
                //   activeColor: Colors.red,
                //   onChanged: (bool value) {
                //     // This is called when the user toggles the switch.
                //     setState(() {
                //       light = value;
                //     });
                //   },
                // ),
                // Checkbox(
                //
                //   activeColor : Colors.green,
                //   value: value,
                //   onChanged: (value) {
                //     setState(() {
                //       this.value = value!;
                //     });
                //   },
                // ),
                ListTile(
                  title: const Text('www.javatpoint.com'),
                  leading: Radio(
                    value: BestTutorSite.javatpoint,
                    groupValue: _site,
                    onChanged: ( value) {
                      setState(() {
                        _site = value!;
                      });
                    },
                  ),
                ),
                // ListTile(
                //   title: const Text('www.w3school.com'),
                //   leading: Radio(
                //     value: BestTutorSite.w3schools,
                //     groupValue: _site,
                //     onChanged: (value) {
                //       setState(() {
                //         _site = value!;
                //       });
                //     },
                //   ),
                // ),
                // ListTile(
                //   title: const Text('www.tutorialandexample.com'),
                //   leading: Radio(
                //     value: BestTutorSite.tutorialandexample,
                //     groupValue: _site,
                //     onChanged: (value) {
                //       setState(() {
                //         _site = value!;
                //       });
                //     },
                //   ),
                // ),

                DropdownButton(
                  alignment: Alignment.centerRight,
                  // Initial Value
                  value: dropdownvalue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                // const SizedBox(height: 50,),
                GestureDetector(
                  onTap: () {

                    traverseWidgetTree(context);
                  },
                  child: Image.asset("assets/home.png", height: 200, width: 200),
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
       // key: const ValueKey<String>("floating-btn"),
        onPressed: () async {
         // traverseWidgetTree(context);
           FieldCapture().fieldCapture(context);
          //debugPrint("floating button clicked");
          //List<Map<String,dynamic>> fieldTrackingData =  await ScreenTracking().traverseWidgetTree(this.context);
          },
        child:const Icon(Icons.find_in_page),
      ),
    );
  }
     traverseWidgetTree(BuildContext element) {
       final widget = element.widget;

       final elements = element as Element;
       final widgetName = element.runtimeType.toString();
       final widgetData = <String, dynamic>{};

       if (element.widget is Text) {
         final textWidget = element.widget as Text;
         widgetData['data'] = textWidget.data;
       } else if (element.widget is RichText) {

       }
       else if (element.widget is ElevatedButton) {
         var btnWidget = element as ButtonStyleButton;

        var key = element.widget.key;

         _btnListener() {
           print('Material btn pressed!!!');
         }

         MaterialStatesController? statesControllers = btnWidget
             .statesController;
         if(statesControllers != null) {
           statesControllers?.update(MaterialState.disabled, false);
           statesControllers?.addListener(_btnListener);
         }

      MaterialStatesController internalStatesController = MaterialStatesController();
      MaterialStatesController? statesController = btnWidget.statesController ?? internalStatesController;
      statesController.update(MaterialState.disabled, false);
      statesController?.addListener(_btnListener);

    }
    else if (element.widget is TextField ) {
      if (element.widget.key.toString() == emailIdFieldKey.toString()){
        final currentWidget = element.widget as TextField;
      TextEditingController controller = (currentWidget.controller!);
      _onControllerChanged() {
        debugPrint("valueChanged: ${controller.text}");
        FocusScopeNode currentFocus = FocusScope.of(element);

        // urrentFocus.hasPrimaryFocus) {
        //   // currentFocus.unfocus();
        //   print("focus has changed");
        // }
      }
      _onEditingCompleted() {

      }

      controller.addListener(_onControllerChanged);

      controller.addListener(() {
        // Do something when text changes
      });
    }
    }

    element.visitChildElements((child) {
      traverseWidgetTree(child);
    });
  }

}

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: 200,
        child: ListView.separated(
          itemBuilder: (context, position) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'List Item $position',
                ),
              ),
            );
          },
          separatorBuilder: (context, position) {
            return Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Separator $position',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
