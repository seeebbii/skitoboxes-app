import 'package:get/get.dart';

class AuthDataHandlingController extends GetxController {


  static AuthDataHandlingController instance = Get.find();

  var userName = ''.obs, userEmail = ''.obs, userPassword = ''.obs, userPhone = ''.obs;

}