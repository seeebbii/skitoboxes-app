// STATIC ROUTES NAME
import 'package:flutter/material.dart';
import 'package:skitoboxes/home_screen.dart';
import 'package:skitoboxes/models/address.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/views/authentication/auth_page_viewer.dart';
import 'package:skitoboxes/views/box_details.dart';
import 'package:skitoboxes/views/info/landing_page.dart';
import 'package:skitoboxes/views/profile_settings/address/add_addres_screen.dart';
import 'package:skitoboxes/views/profile_settings/address/address_field_body.dart';
import 'package:skitoboxes/views/profile_settings/address/edit_address_screen.dart';
import 'package:skitoboxes/views/profile_settings/address/manage_address_screen.dart';
import 'package:skitoboxes/views/profile_settings/subscription_screen.dart';
import 'package:skitoboxes/views/purchase/cart_screen.dart';
import 'package:skitoboxes/views/purchase/payment_screen.dart';
import 'package:skitoboxes/views/splash/main_splash_screen.dart';

const String initialRoute = '/';
const String signUp = '/signup';
const String landing = '/landing';
const String bodyAuth = '/bodyAuth';
const String homeScreen = '/home-screen';
const String boxDetails = '/box-details';
const String cart = '/cart';
const String subscriptionScreen = '/subscription-screen';
const String payment = '/payment';
const String manageAddress = '/manage-address';
const String addressForm = '/address-form';

// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

class RouteGenerator {
  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    final args = settings.arguments as Map;

    switch (settings.name) {
      case initialRoute:
        return _getPageRoute(const MainSplashScreen());

      case landing:
        return _getPageRoute(LandingPage());

      case bodyAuth:
        return _getPageRoute(const AuthPageViewer());

      case homeScreen:
        return _getPageRoute(HomeScreen());

      case boxDetails:
        return _getPageRoute(BoxDetails(box: args['boxDetails'] as Box));

      case cart:
        return _getPageRoute(CartScreen());

      case subscriptionScreen:
        return _getPageRoute(const SubscriptionScreen());

      case payment:
        return _getPageRoute(const PaymentScreen());

      case manageAddress:
        return _getPageRoute(ManageAddressScreen());

      case addressForm:
        return _getPageRoute(AddressForm(
          typeMode: args['typeMode'] as FormType,
          address: args['address'] as Address,
        ));

      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (ctx) => child);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}
