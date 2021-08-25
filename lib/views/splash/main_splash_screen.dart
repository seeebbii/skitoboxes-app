import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/views/splash/screen_title.dart';

class MainSplashScreen extends StatelessWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              child: RiveAnimation.asset(
                'assets/animation/logo.riv',
              ),
            ),
            Container(
              child: ScreenTitle(text: 'SKITO'),
            ),
          ],
        ),
      ),
    );
  }
}
