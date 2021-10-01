import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool verify = false;
  String completedPin = '';

  _trySubmit(String pin) async {
    FocusScope.of(context).unfocus();
    authController
        .verifyAccount(
            authDataHandlingController.nameController.value.text,
            authDataHandlingController.emailController.value.text,
            authDataHandlingController.passwordController.value.text,
            authDataHandlingController.phoneController.value.text,
            pin)
        .then((response) {
      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)['message'];
        CustomSnackBar.showSnackBar(
            title: message, message: '', backgroundColor: snackBarSuccess);
        navigationController.sheetController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else if (response.statusCode == 500) {
        CustomSnackBar.showSnackBar(
            title: "Invalid Otp", message: '', backgroundColor: snackBarError);
      }
    });
  }

  getMobileFormWidget(context) {
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
                    'Please confirm your profile',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    'The code has been sent to +92 3${authDataHandlingController.phoneController.value.text}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Obx(
                    () => authDataHandlingController.start.value == 0
                        ? TextButton(
                            child: const Text('Resend Otp'),
                            onPressed: () {
                              authController
                                  .resendOtp(
                                      authDataHandlingController
                                          .nameController.value.text,
                                      authDataHandlingController
                                          .emailController.value.text,
                                      authDataHandlingController
                                          .passwordController.value.text,
                                      authDataHandlingController
                                          .phoneController.value.text)
                                  .then((response) {
                                if (response.statusCode == 200) {
                                  String message = jsonDecode(response.body)['message'];
                                  CustomSnackBar.showSnackBar(
                                      title: message,
                                      message: '',
                                      backgroundColor: snackBarSuccess);
                                } else if (response.statusCode == 500) {
                                  String message =
                                      jsonDecode(response.body)['message'];
                                  CustomSnackBar.showSnackBar(
                                      title: message,
                                      message: '',
                                      backgroundColor: snackBarError);
                                }
                              });
                              authDataHandlingController.startTimer();
                            },
                          )
                        : Text(
                            '${authDataHandlingController.start.value}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey.shade800),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (pin) {
                    if (pin.length != 6) {
                      setState(() {
                        verify = false;
                        completedPin = pin;
                      });
                    }
                  },
                  onCompleted: (pin) async {
                    setState(() {
                      verify = true;
                      completedPin = pin;
                    });
                    _trySubmit(pin);
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SIGN UP',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  FloatingActionButton(
                    onPressed: verify
                        ? () {
                            _trySubmit(completedPin);
                          }
                        : null,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    backgroundColor: verify
                        ? Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor
                        : Colors.grey,
                    elevation:
                        Theme.of(context).floatingActionButtonTheme.elevation,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: getMobileFormWidget(context),
    ));
  }
}
