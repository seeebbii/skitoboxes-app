import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {

  final sheetController = PageController(
    keepPage: true,
    initialPage: 0,
  );


  @override
  void onInit() {
    super.onInit();
    sheetController.addListener(() {

    });
  }

  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic>? getOffAll(String routeName) {
    return Get.offAllNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
