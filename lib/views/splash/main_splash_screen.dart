import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
class MainSplashScreen extends StatelessWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: orange,
      body: Center(
        child: Text('SPLASH', style: TextStyle(fontSize: 20) ,),
      ),
    );
  }
}
