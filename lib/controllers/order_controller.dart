import 'package:get/get.dart';
import 'package:skitoboxes/models/address.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  // temporary model
  var address = <Address>[].obs;
  var selectedAddress;
}
