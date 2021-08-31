import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';
import 'package:skitoboxes/utils/auth_exception_handler.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with AutomaticKeepAliveClientMixin<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool verificationAllowed = false;

  void otpSheet(BuildContext ctx) {
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
              child: OtpBottomSheet(),
            ),
          );
        });
  }


  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      otpSheet(context);
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
            Form(
              key: _formKey,
              child: Padding(
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
                        }else if(value.length != 9){
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authDataHandlingController.userPhone.value  = value!;
                      },
                      decoration: InputDecoration(
                        prefixText: '+ 92 - 3',
                        labelText: 'Phone',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),],
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
                    'SEND',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  FloatingActionButton(
                    onPressed: _trySubmit,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    backgroundColor:Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor ,
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class OtpBottomSheet extends StatefulWidget {
  OtpBottomSheet({Key? key,}) : super(key: key);

  @override
  _OtpBottomSheetState createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trySubmit();
  }


  void trySubmit()async{
    // CONFIRM OTP AND THEN Create user on auth request
    // PHONE OTP AUTHENTICATION
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+923${authDataHandlingController.userPhone.value}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (result.user != null) {
          print('CODE SUCCESSFUL');

          final status = await authController.createUser(
              authDataHandlingController.userEmail.value,
              authDataHandlingController.userPassword.value,
              authDataHandlingController.userName.value,
            authDataHandlingController.userPhone.value,);
          if (status == AuthResultStatus.successful) {
            CustomSnackBar.showSnackBar(
                title: "Account created Successfully",
                message: '',
                backgroundColor: snackBarSuccess);
          } else {
            final errorMsg =
            AuthExceptionHandler.generateExceptionMessage(status);
            CustomSnackBar.showSnackBar(
                title: errorMsg, message: '', backgroundColor: snackBarError);
          }
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          CustomSnackBar.showSnackBar(
              title: 'The provided phone number is not valid',
              message: '',
              backgroundColor: snackBarError);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: myCode!);
        UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
        if(result.user != null){
          print('CODE SUCCESSFUL');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  bool verificationAllowed = false;
  String? myCode;

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
                    'Please confirm your profile',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
                onChanged: (val) {
                  debugPrint(val);
                  myCode = val;
                  if(val.length != 6){
                    setState(() {
                      verificationAllowed = false;
                    });
                  }
                },
                onCompleted: (pin) {
                  myCode = pin;
                  if(pin.length == 6){
                    setState(() {
                      verificationAllowed = true;
                    });
                  }
                },
              ),
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
                    onPressed: verificationAllowed ? (){
                      // CHECK CODE

                    }
                        : null,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    backgroundColor: verificationAllowed ? Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor : Colors.grey,
                    elevation:
                    Theme.of(context).floatingActionButtonTheme.elevation,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
          ],
        ),
      )
    );
  }
}



