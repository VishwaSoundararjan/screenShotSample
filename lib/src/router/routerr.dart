import 'package:screenshotsample/src/data/model/order.dart';
import 'package:screenshotsample/src/data/model/product.dart';
import 'package:screenshotsample/src/router/router_path.dart';
import 'package:screenshotsample/src/view/screen/add_address_screen.dart';
import 'package:screenshotsample/src/view/screen/change_pass_screen.dart';
import 'package:screenshotsample/src/view/screen/checkout_screen.dart';
import 'package:screenshotsample/src/view/screen/choice_address_screen.dart';
import 'package:screenshotsample/src/view/screen/detail_product_screen.dart';
import 'package:screenshotsample/src/view/screen/forgot_pass_screen.dart';
import 'package:screenshotsample/src/view/screen/login_screen.dart';
import 'package:screenshotsample/src/view/screen/my_order_screen.dart';
import 'package:screenshotsample/src/view/screen/order_detail_screen.dart';
import 'package:screenshotsample/src/view/screen/order_success_screen.dart';
import 'package:screenshotsample/src/view/screen/otp_screen.dart';
import 'package:screenshotsample/src/view/screen/recent_view_screen.dart';
import 'package:screenshotsample/src/view/screen/register_screen.dart';
import 'package:screenshotsample/src/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routerr{
  static RouteFactory onGenerateRouter = (RouteSettings settings){
    switch(settings.name){
      case DetailProductScreens:
        final arg = settings.arguments! as Product;
        return _generateMaterialRoute(DetailProductScreen(product: arg,));
      case CheckoutScreens:
        return _generateMaterialRoute(CheckoutScreen());
      case ChoiceAddressScreens:
        return _generateMaterialRoute(const ChoiceAddressScreen());
      case AddAddressScreens:
        return _generateMaterialRoute(AddAddressScreen());
      case OrderSuccessScreens:
        return _generateMaterialRoute(const OrderSuccessScreen());
      case MyOrderScreens:
        return _generateMaterialRoute(const MyOrderScreen());
      case OrderDetailScreens:
        final arg = settings.arguments! as Order;
        return _generateMaterialRoute(OrderDetailScreen(order: arg,));
      case RecentViewScreens:
        final arg = settings.arguments! as List<Product>;
        return _generateMaterialRoute(RecentViewScreen(listRecentProduct: arg,));
      case SplashScreens:
        return _generateMaterialRoute(const SplashScreen());
      case LoginScreens:
        return _generateMaterialRoute(const LoginScreen());
      case RegisterScreens:
        return _generateMaterialRoute(RegisterScreen());
      case ForgotPassScreens:
        return _generateMaterialRoute(const ForgotPassScreen());
      case ChangePassScreens:
        return _generateMaterialRoute(const ChangePassScreen());
      case OtpScreens:
        return _generateMaterialRoute(const OtpScreen());
      default:
        return _generateMaterialRoute(const Center(child: Text("On Unknown Router",style: TextStyle(
          color: Colors.red,
          fontSize: 25,
        ),),));
    }
  };
}

PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(child: screen,type: PageTransitionType.fade);
}