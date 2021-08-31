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

  // CHECKING DUPLICATE EMAIL
  Future<List<String>> checkDuplicateEmail(String email) async {
    return await _auth.fetchSignInMethodsForEmail(email);
  }


  //  CREATE USER WITH EMAIL AND PASSWORD
  Future<AuthResultStatus> createUser(String email, String password, String userName, String userPhone) async {
    try {

      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      if(_authResult.user != null){
        _status = AuthResultStatus.successful;
        AuthModel _user = AuthModel(
            uid: _authResult.user!.uid,
            name: userName,
            email: email.trim(),
            phoneNumber: int.parse(userPhone)
        );
        currentUser.value = _user;
      }else{
        _status = AuthResultStatus.undefined;
      }

    } on FirebaseAuthException catch  (e) {
      debugPrint(e.code);
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

    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }


  // PHONE OTP AUTHENTICATION
  // void verifyPhoneNumber(String number) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: '+92 3$number',
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async{
  //       UserCredential result = await _auth.signInWithCredential(credential);
  //       if(result.user != null){
  //         print('CODE SUCCESSFUL');
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         CustomSnackBar.showSnackBar(title: 'The provided phone number is not valid', message: '', backgroundColor: snackBarError);
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }


  // LOGOUT
  void logOut() async {
    try {
      await _auth.signOut();
      navigationController.getOffAll(landing);
    } catch (e) {
      CustomSnackBar.showSnackBar(title: e.toString(), message: '', backgroundColor: snackBarError);
    }
  }

}