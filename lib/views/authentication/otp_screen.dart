import 'package:flutter/material.dart';


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

  // final phoneController = TextEditingController();
  // final otpController = TextEditingController();
  // final userController = Get.put(AuthController());




  // getMobileFormWidget(context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Column(
  //             children: [
  //               Container(
  //                 height: 60,
  //                 width: 60,
  //                 child: const RiveAnimation.asset(
  //                   'assets/animation/logo_orange.riv',
  //                 ),
  //               ),
  //               Container(
  //                 child: Text(
  //                   'SKITO',
  //                   style: Theme.of(context)
  //                       .primaryTextTheme
  //                       .headline5!
  //                       .copyWith(fontSize: 24, color: orange),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.width * 0.05),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 60),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Please confirm your profile',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .bodyText1!
  //                       .copyWith(fontSize: 22),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.width * 0.1),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 40),
  //             child: Form(
  //               key: _formKey,
  //               child: Column(
  //                 children: [
  //                   TextFormField(
  //                     maxLength: 9,
  //                     textInputAction: TextInputAction.done,
  //                     controller: phoneController,
  //                     keyboardType: TextInputType.number,
  //                     validator: (value) {
  //                       if (value!.isEmpty) {
  //                         return 'Please enter your phone number';
  //                       } else if (value.length != 9) {
  //                         return 'Invalid phone number';
  //                       }
  //                       return null;
  //                     },
  //                     onChanged: (value){
  //                       authDataHandlingController.userPhone.value = value;
  //                     },
  //                     decoration: InputDecoration(
  //                       prefixText: '+ 92 - 3',
  //                       labelText: 'Phone',
  //                       labelStyle: Theme.of(context).textTheme.bodyText1,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.width * 0.07),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 30),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'SEND',
  //                   style: Theme.of(context).primaryTextTheme.headline5,
  //                 ),
  //                 FloatingActionButton(
  //                   onPressed: () async {
  //
  //                     final isValid = _formKey.currentState!.validate();
  //                     FocusScope.of(context).unfocus();
  //
  //                     if (isValid) {
  //
  //                       otpSheet(context);
  //
  //                       _formKey.currentState!.save();
  //                       await _auth.verifyPhoneNumber(
  //                         phoneNumber: '+923${phoneController.text}',
  //                         verificationCompleted: (phoneAuthCredential) async {
  //
  //                           //signInWithPhoneAuthCredential(phoneAuthCredential);
  //                         },
  //                         verificationFailed: (verificationFailed) async {
  //                           CustomSnackBar.showSnackBar(
  //                               title: 'Invalid Otp',
  //                               message: '',
  //                               backgroundColor: snackBarError);
  //                         },
  //                         codeSent: (codeRec, resendingToken) async {
  //                           setState(() {
  //                             verificationId = codeRec;
  //                           });
  //                         },
  //                         codeAutoRetrievalTimeout: (verificationId) async {},
  //                       );
  //                     }
  //                   },
  //                   child: const Icon(
  //                     Icons.arrow_forward_ios,
  //                     color: Colors.white,
  //                   ),
  //                   backgroundColor: Theme.of(context)
  //                       .floatingActionButtonTheme
  //                       .backgroundColor,
  //                   elevation:
  //                       Theme.of(context).floatingActionButtonTheme.elevation,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.width * 0.1),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // otpSheet(BuildContext ctx) {
  //   showModalBottomSheet(
  //       isDismissible: true,
  //       enableDrag: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       isScrollControlled: true,
  //       context: ctx,
  //       builder: (context) {
  //         return ClipRRect(
  //           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //           child: Container(
  //             height: MediaQuery.of(ctx).size.height * 0.95,
  //             child: Scaffold(
  //                 body: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   Column(
  //                     children: [
  //                       Container(
  //                         height: 60,
  //                         width: 60,
  //                         child: const RiveAnimation.asset(
  //                           'assets/animation/logo_orange.riv',
  //                         ),
  //                       ),
  //                       Container(
  //                         child: Text(
  //                           'SKITO',
  //                           style: Theme.of(context)
  //                               .primaryTextTheme
  //                               .headline5!
  //                               .copyWith(fontSize: 24, color: orange),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: MediaQuery.of(context).size.width * 0.05),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 60),
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           'Please confirm your profile',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText1!
  //                               .copyWith(fontSize: 22),
  //                         ),
  //                         SizedBox(
  //                             height: MediaQuery.of(context).size.width * 0.02),
  //                         Text(
  //                           'The code has been sent to +92 3${authDataHandlingController.userPhone}',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText1!
  //                               .copyWith(color: Colors.grey.shade600),
  //                           textAlign: TextAlign.center,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: MediaQuery.of(context).size.width * 0.07),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 10),
  //                     child: OTPTextField(
  //                         length: 6,
  //                         width: MediaQuery.of(context).size.width,
  //                         fieldWidth: 50,
  //                         style: const TextStyle(fontSize: 17),
  //                         textFieldAlignment: MainAxisAlignment.spaceEvenly,
  //                         fieldStyle: FieldStyle.underline,
  //                         onChanged: (pin) {},
  //                         onCompleted: (pin) async {
  //                           PhoneAuthCredential phoneAuthCredential =
  //                               PhoneAuthProvider.credential(
  //                                   verificationId: verificationId!,
  //                                   smsCode: pin);
  //
  //                           Future.delayed(const Duration(milliseconds: 1000),
  //                               () {
  //                             signInWithPhoneAuthCredential(
  //                                 phoneAuthCredential);
  //                           });
  //                         }),
  //                   ),
  //                   SizedBox(height: MediaQuery.of(context).size.width * 0.07),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 30),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           'SIGN UP',
  //                           style: Theme.of(context).primaryTextTheme.headline5,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: MediaQuery.of(context).size.width * 0.1),
  //                 ],
  //               ),
  //             )),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            child: const Center(child:  Text('Code'))
          )),
    );
  }
}

