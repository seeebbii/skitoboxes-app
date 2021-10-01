import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skitoboxes/constants/uri.dart';
import 'model/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  
  var currentUser = AuthModel().obs;


  Future<http.Response> registerUser(String username, String email, String password, String phoneNumber) async {
    var url = Uri.parse('$base_url/auth/register');
    try {
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'username' : username,
            'email' : email,
            'password' : password,
            'phoneNumber' : "+923$phoneNumber"
          }));

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


  Future<http.Response> loginUser(String email, String password) async {
    String token = await firebaseToken();
    var url = Uri.parse('$base_url/auth/login');
    try {
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email' : email,
            'password' : password,
            'fcmToken' : token
          }));

      if(response.statusCode == 200){
        currentUser.value = AuthModel.fromJson(jsonDecode(response.body));
        saveUserState(currentUser.value.mongodbId!);
      }

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<http.Response> verifyAccount(String username, String email, String password, String phoneNumber, String code) async {
    var url = Uri.parse('$base_url/auth/verify');
    try {
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'username' : username,
            'email' : email,
            'password' : password,
            'phoneNumber' : "+923$phoneNumber",
            'code' : code
          }));

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<http.Response> resendOtp(String username, String email, String password, String phoneNumber) async {
    var url = Uri.parse('$base_url/auth/resend');
    try {
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'username' : username,
            'email' : email,
            'password' : password,
            'phoneNumber' : "+923$phoneNumber"
          }));

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


  Future<String> firebaseToken() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    String? token = await fcm.getToken();
    if(token != ''){
      return token ?? "Failed";
    }else{
      return "Failed";
    }
  }

  void saveUserState(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", true);
    prefs.setString('userId', id);
  }

  Future getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt('userId') != null){
      return prefs.getInt('userId');
    }
  }

  void logOutUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", false);
    // Get.offAll(() => LoginPage());
  }

}