class AuthModel {
  String? uid;
  String? mongodbId;
  String? name;
  String? email;
  int? phoneNumber;
  String? imageUrl;

  AuthModel({this.uid, this.mongodbId, this.name, this.email, this.phoneNumber, this.imageUrl});

  AuthModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    mongodbId = json['mongodbId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
  }
}
