import 'package:screenshotsample/src/const/app_colors.dart';
import 'package:screenshotsample/src/const/app_font.dart';
import 'package:screenshotsample/src/router/router_path.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Checkout",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextHeader(title: "Shipping address"),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Janne",
                        style: AppFont.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ChoiceAddressScreens);
                        },
                        child: Text(
                          "Change",
                          style: AppFont.regular.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: AppColors.primaryColorRed),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "0927827763",
                    style: AppFont.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "194 ngyen cong tru",
                    style: AppFont.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Phuong 12 quan 1",
                    style: AppFont.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                buildTextHeader(title: "Payment"),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "Change",
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppColors.primaryColorRed),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  "Order",
                  style: AppFont.medium.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: AppColors.primaryColorGray),
                ),
                const Spacer(),
                Text(
                  "11VND",
                  style: AppFont.semiBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Delivery",
                  style: AppFont.medium.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: AppColors.primaryColorGray),
                ),
                const Spacer(),
                Text(
                  "11VND",
                  style: AppFont.semiBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Summary",
                  style: AppFont.medium.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primaryColorGray),
                ),
                const Spacer(),
                Text(
                  "11VND",
                  style: AppFont.semiBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                    textStyle: AppFont.medium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),),
                onPressed: () => Navigator.pushNamed(context, OrderSuccessScreens),
                child: Text('Submit order'.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextHeader({required String title}) {
    return Text(
      title,
      style:
          AppFont.semiBold.copyWith(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}
