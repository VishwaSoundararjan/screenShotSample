import 'package:screenshotsample/src/const/app_colors.dart';
import 'package:screenshotsample/src/const/app_font.dart';
import 'package:screenshotsample/src/data/model/address.dart';
import 'package:screenshotsample/src/view/screen/component/addaddress/text_field_address.dart';
import 'package:screenshotsample/src/viewmodel/address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressDetailController = TextEditingController();

  AddAddressScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context,listen: false);
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
          "Add Shipping Address",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFieldAddress(

                textEditingController: nameController,
                lableText: "Full name",
                ),
            const SizedBox(
              height: 18,
            ),
            TextFieldAddress(
                textEditingController: phoneController,
                lableText: "Phone"),
            const SizedBox(
              height: 18,
            ),
            TextFieldAddress(
                textEditingController: addressDetailController,
                lableText: "Address Description"),
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
                onPressed: () {
                  addressViewModel.addAddress(Address(id: "",userName: nameController.text,phone: phoneController.text,addressTitle1: addressDetailController.text,addressTitle2: ""));
                },
                child: Text('save address'.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
