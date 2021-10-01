import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDataHandlingController extends GetxController {


  static AuthDataHandlingController instance = Get.find();

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;

  var start = 30.obs;
  Timer? timer;

  @override
  void onInit() {
    timer = Timer(Duration(seconds: 1), () { });
    super.onInit();
  }

  void startTimer() {
    print('Timer Started');
    start.value = 30;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0) {
            timer.cancel();
        } else {
          start--;
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

}