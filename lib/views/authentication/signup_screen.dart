import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with AutomaticKeepAliveClientMixin<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _userName, _userEmail, _userPassword;
  bool obSecure = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _userPhone;
  TextEditingController phoneController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // IF THE DATA IS VALIDATED, TAKE USER TO OTP SCREEN FOR CONFIRMATION
      navigationController.sheetController.animateToPage(2, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
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
                      onSaved: (value) {
                        _userName = value;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return "your password must have 8 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
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
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPhone = value;
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
