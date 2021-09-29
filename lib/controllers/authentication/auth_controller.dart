import 'package:get/get.dart';
import 'model/auth_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  
  var currentUser = AuthModel().obs;



}