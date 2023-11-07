import 'dart:async';

import 'package:screenshotsample/src/const/app_font.dart';
import 'package:screenshotsample/src/data/model/product.dart';
import 'package:screenshotsample/src/router/router_path.dart';
import 'package:screenshotsample/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import '../../../../../main.dart';
import '../../../../../traverse_widgets (3).dart';
import 'cart_product.dart';
class BodyPage extends StatefulWidget {
  const BodyPage({super.key});


  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
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
    ProductViewModel prductVM = Provider.of(context,listen: false);
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);
     const oneSec = Duration(seconds: 2);
     _timer=  Timer.periodic(oneSec, (Timer timer) async {
    // This statement will be printed after every one second
    //    takeScreenshotMethod();
    //    updateViewJson();
     });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderBody(title: "Sale", description: "Supper sale"),

          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: cardWidth / 0.59,
            child: ListView.builder(
              itemCount:  prductVM.listProduct?.length,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_,index){
                Product? product = prductVM.listProduct![index];
                return InkWell(
                  onTap: (){
                    prductVM.addRecentView(product);
                    _timer.cancel();
                    Navigator.pushNamed(context,DetailProductScreens,arguments: product);
                  },
                  child: CartProduct(
                    index: index,
                    product: product,
                  ),
                );
              },
            )
          ),
          const SizedBox(
            height: 30,
          ),
          buildHeaderBody(title: "New", description: "Supper new"),

          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: cardWidth / 0.59,
              child: ListView.builder(
                itemCount:  prductVM.listProduct?.length,
                padding: const EdgeInsets.all(0.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,index){
                  Product? product = prductVM.listProduct![index];
                  return InkWell(
                    onTap: (){
                      prductVM.addRecentView(product);
                      Navigator.pushNamed(context,DetailProductScreens,arguments: product);
                    },
                    child: CartProduct(
                      index: index,
                      product: product,
                    ),
                  );
                },
              )
          ),
          // SizedBox(
          //   height: 40,
          // ),
          // buildHeaderBody(title: "New", description: "You’ve never seen it before!"),
          //
          // SizedBox(
          //   height: 20,
          // ),
          //
          // SizedBox(
          //     height: cardWidth / 0.59,
          //     child: ListView.builder(
          //       itemCount: 10,
          //       padding: EdgeInsets.all(0.0),
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (_,index){
          //         return CartProduct();
          //       },
          //     )
          // ),
        ],
      ),
    );
  }

  Widget buildHeaderBody({required String title,required String description}){
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,style: AppFont.bold.copyWith(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 8,
            ),
            Text(description,style: AppFont.regular.copyWith(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),),
          ],
        ),
        const Spacer(),
        Text('View all',style: AppFont.regular.copyWith(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),),
      ],
    );
  }
}
