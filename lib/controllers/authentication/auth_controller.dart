import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/utils/auth_exception_handler.dart';

import 'model/auth_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser.obs;
  var currentUser = AuthModel().obs;

  AuthResultStatus? _status;

  @override
  void onInit() {
    super.onInit();
    // BINDING AUTH LISTENER
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  //  CREATE USER WITH EMAIL AND PASSWORD
  Future<AuthResultStatus> createUser(String email, String password,
      String userName, int userAge, int userPhone) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      if (_authResult.user != null) {
        _status = AuthResultStatus.successful;
        AuthModel _user = AuthModel(
            uid: _authResult.user!.uid,
            name: userName,
            email: email.trim(),
            phoneNumber: userPhone);
        currentUser.value = _user;
        navigationController.goBack();
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      debugPrint(e.toString());
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  // Login with email and password
  Future<AuthResultStatus> loginUser(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      if (_authResult.user != null) {
        _status = AuthResultStatus.successful;

        AuthModel _user = AuthModel(
          uid: _authResult.user!.uid,
          name: '',
          email: email.trim(),
        );

        currentUser.value = _user;

        // TODO :: LOAD USER INFO FROM MONGO DB COLLECTION
        navigationController.getOffAll(homeScreen);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      debugPrint(e.toString());
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  // LOGOUT
  void logOut() async {
    try {
      await _auth.signOut();
      navigationController.getOffAll(landing);
    } catch (e) {
      CustomSnackBar.showSnackBar(
          title: e.toString(), message: '', backgroundColor: snackBarError);
    }
  }
}
