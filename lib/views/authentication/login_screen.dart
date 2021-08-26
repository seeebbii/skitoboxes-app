import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';
import 'package:skitoboxes/views/authentication/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void loginSheet(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(ctx).size.height * 0.90,
              child: SignupScreen(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => NavigationController.instance.goBack(),
                  child: Icon(Icons.close, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: CircleBorder(),
                    primary: Colors.grey.shade300.withOpacity(0.6),
                  ),
                ),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
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
                  OutlinedButton(
                      onPressed: () => NavigationController.instance.goBack(),
                      child: Icon(Icons.arrow_forward_ios),
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                      )),
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
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => NavigationController.instance.goBack(),
                  child: Text('f'),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50)),
                ),
                ElevatedButton(
                  onPressed: () => NavigationController.instance.goBack(),
                  child: Text('G'),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50)),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.15),
            Text("Don't have account?",
                style: Theme.of(context).textTheme.bodyText1),
            TextButton(
              onPressed: () => loginSheet(context),
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
}
