import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';
import 'package:skitoboxes/controllers/authentication/auth_controller.dart';
import 'package:skitoboxes/home_screen.dart';
import 'package:skitoboxes/utils/auth_exception_handler.dart';

enum PhoneVerificationPageState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PhoneVerificationPageState currentState =
      PhoneVerificationPageState.SHOW_MOBILE_FORM_STATE;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final userController = Get.put(AuthController());

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number Verified'),
        backgroundColor: Colors.green,
      ));
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
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
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 9,
                    textInputAction: TextInputAction.done,
                    controller: phoneController,
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
            SizedBox(height: MediaQuery.of(context).size.width * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SEND',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                        phoneNumber: '+923${phoneController.text}',
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(verificationFailed.message!)));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                PhoneVerificationPageState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    },
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
          ],
        ),
      ),
    );
  }

  otpSheet(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(ctx).size.height * 0.95,
              child: Scaffold(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            'The code has been sent to +92 3${authDataHandlingController.userPhone}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey.shade600),
                            textAlign: TextAlign.center,
                          )
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
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) async {
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId!,
                                    smsCode: pin);

                            Future.delayed(Duration(milliseconds: 1000), () {
                              signInWithPhoneAuthCredential(
                                  phoneAuthCredential);
                            });
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
                            onPressed: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            backgroundColor: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            elevation: Theme.of(context)
                                .floatingActionButtonTheme
                                .elevation,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  ],
                ),
              )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            child: showLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState ==
                        PhoneVerificationPageState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : otpSheet(context),
            padding: const EdgeInsets.all(16),
          )),
    );
  }
}

// class OtpBottomSheet extends StatefulWidget {
//   OtpBottomSheet({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _OtpBottomSheetState createState() => _OtpBottomSheetState();
// }

// class _OtpBottomSheetState extends State<OtpBottomSheet> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   trySubmit();
  // }

  // void trySubmit() async {
  //   // CONFIRM OTP AND THEN Create user on auth request
  //   // PHONE OTP AUTHENTICATION
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+923${authDataHandlingController.userPhone.value}',
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       UserCredential result =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       if (result.user != null) {
  //         print('CODE SUCCESSFUL');

  //         final status = await authController.createUser(
  //           authDataHandlingController.userEmail.value,
  //           authDataHandlingController.userPassword.value,
  //           authDataHandlingController.userName.value,
  //           authDataHandlingController.userPhone.value,
  //         );
  //         if (status == AuthResultStatus.successful) {
  //           CustomSnackBar.showSnackBar(
  //               title: "Account created Successfully",
  //               message: '',
  //               backgroundColor: snackBarSuccess);
  //         } else {
  //           final errorMsg =
  //               AuthExceptionHandler.generateExceptionMessage(status);
  //           CustomSnackBar.showSnackBar(
  //               title: errorMsg, message: '', backgroundColor: snackBarError);
  //         }
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         CustomSnackBar.showSnackBar(
  //             title: 'The provided phone number is not valid',
  //             message: '',
  //             backgroundColor: snackBarError);
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //           verificationId: verificationId, smsCode: myCode!);
  //       UserCredential result =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       if (result.user != null) {
  //         print('CODE SUCCESSFUL');
  //       }
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print(verificationId);
  //     },
  //   );
  // }