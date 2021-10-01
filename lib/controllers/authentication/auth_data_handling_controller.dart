import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDataHandlingController extends GetxController {


  static AuthDataHandlingController instance = Get.find();

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;

}