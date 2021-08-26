import 'package:flutter/material.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
