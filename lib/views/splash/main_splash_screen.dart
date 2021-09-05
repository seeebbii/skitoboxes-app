import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:rive/rive.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/views/splash/logo_title.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
        () => navigationController.getOffAll(landing));
  }

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
              child: const RiveAnimation.asset(
                'assets/animation/logo_white.riv',
              ),
            ),
            Container(
              child: LogoTitle(text: 'SKITO'),
            ),
          ],
        ),
      ),
    );
  }
}
