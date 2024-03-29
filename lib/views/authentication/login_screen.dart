import 'dart:convert';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/constants/custom_snackbar.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AutomaticKeepAliveClientMixin<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obSecure = true;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // CALL LOGIN METHOD
      authController.loginUser(emailController.text,passwordController.text).then((response){

        if(response.statusCode == 200){
          navigationController.getOffAll(homeScreen);
          CustomSnackBar.showSnackBar(title: 'Login Successful', message: '', backgroundColor: snackBarSuccess);
        }else{
          String message = jsonDecode(response.body)['error'];
          CustomSnackBar.showSnackBar(title: message, message: '', backgroundColor: snackBarError);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'WELCOME BACK',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline5!
                    .copyWith(fontSize: 38),
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
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextFormField(
                      obscureText: obSecure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SIGN IN',
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
            TextButton(
              onPressed: () {},
              child: Text(
                'FORGOT PASSWORD?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600, color: darkBlue),
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () => authController.loginWithGoogle(),
            //       child: const Text('f'),
            //       style: ElevatedButton.styleFrom(
            //           padding: const EdgeInsets.symmetric(horizontal: 50)),
            //     ),
            //     ElevatedButton(
            //       onPressed: () => authController.loginWithGoogle(),
            //       child: const Text('G'),
            //       style: ElevatedButton.styleFrom(
            //           padding: const EdgeInsets.symmetric(horizontal: 50)),
            //     ),
            //   ],
            // ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.15),
            Text("Don't have an account?",
                style: Theme.of(context).textTheme.bodyText1),
            TextButton(
              onPressed: () => navigationController.sheetController
                  .animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
              child: Text(
                'SIGN UP',
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
  bool get wantKeepAlive => true;
}
