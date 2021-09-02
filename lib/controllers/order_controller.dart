import 'package:get/get.dart';
import 'package:skitoboxes/models/address.dart';

class OrderController extends GetxController {
  // temporary model
  var address = <Address>[
    Address(
      id: 1,
      name: 'Home',
      receiverName: 'John Doe',
      receiverNumber: '+91-1234567890',
      address: '123 Main Street',
      city: 'Mumbai',
      province: 'Maharashtra',
      zipCode: '400056',
    ),
  ].obs;
}
