import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:rive/rive.dart';

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
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 1000),
                builder: (BuildContext context, double _val, child) {
                  return Opacity(
                    opacity: _val,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: _val * 50),
                      child: child,
                    ),
                  );
                },
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeIn,
                child: Text(
                  'SKITO',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Akira',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
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
