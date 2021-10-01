import 'package:skitoboxes/models/address.dart';
import 'package:skitoboxes/models/payment_card.dart';

class AuthModel {
  String? mongodbId;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? fcmToken;
  // List<Address>? address;
  // PaymentCard? paymentCard;

  AuthModel(
      {
      this.mongodbId,
      this.name,
      this.email,
      this.phoneNumber,
      this.imageUrl,
      this.fcmToken,
      // this.address,
      // this.paymentCard
      });

  AuthModel.fromJson(Map<String, dynamic> json) {
    mongodbId = json['_id'];
    name = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    fcmToken = json['fcmToken'];
    // address = json['address'];
    // paymentCard = json['paymentCard'];
  }
}
