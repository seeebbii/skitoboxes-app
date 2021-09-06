import 'package:get/get.dart';
import 'package:skitoboxes/models/address.dart';
import 'package:skitoboxes/models/payment_card.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  // temporary model
  var address = <Address>[].obs;
  var selectedAddress;

  var paymentCards = <PaymentCard>[].obs;
  var selectedPaymentCard;
}
