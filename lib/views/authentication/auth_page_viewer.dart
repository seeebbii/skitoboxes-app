import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/views/authentication/login_screen.dart';
import 'package:skitoboxes/views/authentication/otp_screen.dart';
import 'package:skitoboxes/views/authentication/signup_screen.dart';

class AuthPageViewer extends StatefulWidget {
  const AuthPageViewer({Key? key}) : super(key: key);

  @override
  State<AuthPageViewer> createState() => _AuthPageViewerState();
}

class _AuthPageViewerState extends State<AuthPageViewer> {
  int currentPage = 0;




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
            child: currentPage == 2
                ? ElevatedButton(
                    onPressed: () => navigationController.sheetController
                        .animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                    child: Icon(
                        currentPage == 2
                            ? Icons.arrow_back_ios_outlined
                            : Icons.close,
                        color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const CircleBorder(),
                      primary: Colors.grey.shade300.withOpacity(0.6),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () => navigationController.goBack(),
                    child: const Icon(Icons.close, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const CircleBorder(),
                      primary: Colors.grey.shade300.withOpacity(0.6),
                    ),
                  ),
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.sheetController,
        onPageChanged: (index) => setState(() => currentPage = index),
        children: [LoginScreen(), const SignupScreen(), const OtpScreen()],
      ),
    );
  }
}
