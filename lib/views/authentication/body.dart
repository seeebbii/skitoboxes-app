import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';
import 'package:skitoboxes/views/authentication/login_screen.dart';
import 'package:skitoboxes/views/authentication/signup_screen.dart';

class BodyAuth extends StatelessWidget {
  const BodyAuth({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Align(
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
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.sheetController,
        children: [
          LoginScreen(),
          SignupScreen(),
        ],
      ),
    );
  }
}
