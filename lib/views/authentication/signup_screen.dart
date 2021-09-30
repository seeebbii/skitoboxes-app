import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with AutomaticKeepAliveClientMixin<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obSecure = true;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // IF THE DATA IS VALIDATED, TAKE USER TO OTP SCREEN FOR CONFIRMATION
      authController
          .registerUser(
              authDataHandlingController.nameController.value.text,
              authDataHandlingController.emailController.value.text,
              authDataHandlingController.passwordController.value.text,
              authDataHandlingController.phoneController.value.text)
          .then((response) {

        // TODO:: TESTING ONLY
        // navigationController.sheetController
        //     .animateToPage(2,
        //     duration: const Duration(milliseconds: 500),
        //     curve: Curves.easeInOut);

        if (response.statusCode == 200) {
          String message = jsonDecode(response.body)['message'];
          CustomSnackBar.showSnackBar(
              title: message, message: '', backgroundColor: snackBarSuccess);

          // VERIFY OTP
          navigationController.sheetController.animateToPage(2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        } else if (response.statusCode == 500) {
          String message = jsonDecode(response.body)['message'];
          CustomSnackBar.showSnackBar(
              title: message, message: '', backgroundColor: snackBarError);
        } else {
          String message = jsonDecode(response.body)['error'];
          CustomSnackBar.showSnackBar(
              title: message, message: '', backgroundColor: snackBarError);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: const RiveAnimation.asset(
                    'assets/animation/logo_orange.riv',
                  ),
                ),
                Container(
                  child: Text(
                    'SKITO',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline5!
                        .copyWith(fontSize: 24, color: orange),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  Text(
                    'Create your account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    'After registration is complete, you can see our opportunity products.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller:
                          authDataHandlingController.nameController.value,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller:
                          authDataHandlingController.emailController.value,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller:
                          authDataHandlingController.passwordController.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return "your password must have 8 characters";
                        }
                        return null;
                      },
                      obscureText: obSecure,
                      decoration: InputDecoration(
                        suffixIcon: obSecure
                            ? IconButton(
                                icon: const Icon(Icons.visibility_off_outlined),
                                onPressed: () =>
                                    setState(() => obSecure = !obSecure),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.visibility_outlined,
                                ),
                                onPressed: () =>
                                    setState(() => obSecure = !obSecure),
                              ),
                        labelText: 'Password',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      maxLength: 9,
                      textInputAction: TextInputAction.done,
                      controller:
                          authDataHandlingController.phoneController.value,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length != 9) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixText: '+ 92 - 3',
                        labelText: 'Phone',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VERIFICATION',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  FloatingActionButton(
                    onPressed: _trySubmit,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    backgroundColor: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    elevation:
                        Theme.of(context).floatingActionButtonTheme.elevation,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Text("Already have an account?",
                style: Theme.of(context).textTheme.bodyText1),
            TextButton(
              onPressed: () => navigationController.sheetController
                  .animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
              child: Text(
                'SIGN IN',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline5!
                    .copyWith(fontSize: 20, color: darkBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
