import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  final String? text;

  LogoTitle({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
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
        text!,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Akira',
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
