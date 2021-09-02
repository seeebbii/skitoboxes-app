import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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


  final googleSignIn = GoogleSignIn();

  AuthResultStatus? _status;

  @override
  void onInit() {
    super.onInit();
    // BINDING AUTH LISTENER
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // CHECKING DUPLICATE EMAIL
  Future<List<String>> checkDuplicateEmail(String email) async {
    try{
      return await _auth.fetchSignInMethodsForEmail(email);
    } on FirebaseAuthException catch(e){
      rethrow;
    }

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

  // create a user with google/facebook credentials

  Future createUserWithSocial(UserCredential _authResult) async {
    Future.delayed(const Duration(milliseconds: 1000), () async {


      // CHECK IF THE USER STILL EXISTS IN OUR MONGODB DATABASE

      print(_authResult.user!.phoneNumber);


      navigationController.getOffAll(homeScreen);

      // AuthModel _user = AuthModel(
      //   uid: _authResult.user!.uid,
      //   name: _authResult.user!.displayName,
      //   email: _authResult.user!.email,
      //   imageUrl: _authResult.user!.photoURL,
      // );

          // CREATE USER IN DATABASE (MONGO DB)

          // LOAD USER FROM DATABASE (MONGO DB)

    });
  }

  // GOOGLE LOGIN

  void loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    try {
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      _auth.signInWithCredential(credential).then((value) {
        createUserWithSocial(value);
      });

    } catch (e) {
      CustomSnackBar.showSnackBar(title: "Error login Account", message: '', backgroundColor: snackBarError);
      rethrow;
    }
  }

  // LOGOUT
  void logOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      navigationController.getOffAll(landing);
    } catch (e) {
      CustomSnackBar.showSnackBar(title: e.toString(), message: '', backgroundColor: snackBarError);
    }
  }

}