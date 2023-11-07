import 'dart:async';

import 'package:screenshotsample/src/const/app_colors.dart';
import 'package:screenshotsample/src/const/app_font.dart';
import 'package:screenshotsample/src/router/router_path.dart';
import 'package:screenshotsample/src/view/screen/component/addaddress/text_field_address.dart';
import 'package:screenshotsample/src/viewmodel/auth_viemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../traverse_widgets (3).dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
   bool isShowPass = false;
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
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 20,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Login",
                  style: AppFont.bold.copyWith(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // TextFieldAddress(vi
                //     textEditingController: emailController, lableText: "Email"),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Email",
                      alignLabelWithHint: true, // center labastyle
                      labelStyle: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                  child: TextFormField(
                    controller: passController,
                    obscureText: isShowPass,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            isShowPass =! isShowPass;
                          });
                        },
                          child: Icon(
                        isShowPass ? Icons.visibility : Icons.visibility_off,
                        size: 16,
                      )),
                      alignLabelWithHint: true,
                      // center labastyle
                      labelStyle: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context, ForgotPassScreens),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot yours password?",
                      style: AppFont.medium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColorRed,
                      value: true,
                      onChanged: ( value) {

                      },
                    ),
                    Text("Remember me?",style: AppFont.medium.copyWith(
                      fontSize: 14,
                    ),),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: () {
                      _timer.cancel();
                      authViewModel
                          .login()
                          .then((value) => Navigator.pop(context));
                    },
                    child: Text(
                      "Login".toUpperCase(),
                      style: AppFont.medium
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreens);
                  },
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                        text: "Don't have a account? ",
                        style: AppFont.medium.copyWith(fontSize: 13),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: AppFont.bold.copyWith(
                                fontSize: 13, color: AppColors.primaryColorRed),
                          )
                        ]),
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),

                Center(
                  child: Text(
                    'Or',
                    style: AppFont.medium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.1),
                                offset: const Offset(1, 1),
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: SvgPicture.asset(
                          'assets/images/ic_google.svg',
                          width: 10,
                          height: 10,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.1),
                                offset: const Offset(1, 1),
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: SvgPicture.asset(
                          'assets/images/ic_fb.svg',
                          width: 10,
                          height: 10,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
