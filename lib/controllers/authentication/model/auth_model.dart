import 'package:skitoboxes/models/address.dart';
import 'package:skitoboxes/models/payment_card.dart';

class AuthModel {
  String? uid;
  String? mongodbId;
  String? name;
  String? email;
  int? phoneNumber;
  String? imageUrl;
  Address? address;
  PaymentCard? paymentCard;

  AuthModel(
      {this.uid,
      this.mongodbId,
      this.name,
      this.email,
      this.phoneNumber,
      this.imageUrl,
      this.address,
      this.paymentCard});

  AuthModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    mongodbId = json['mongodbId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    paymentCard = json['paymentCard'];
  }
}
