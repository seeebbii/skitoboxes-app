import 'package:flutter/material.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => NavigationController.instance.goBack(),
                child: Icon(Icons.facebook_outlined),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
              ),
              ElevatedButton(
                onPressed: () => NavigationController.instance.goBack(),
                child: Icon(Icons.facebook_outlined),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'SIGNUP',
                  style: TextStyle(
                    fontFamily: 'Akira',
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'FORGOT PASSWORD?',
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Akira',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
