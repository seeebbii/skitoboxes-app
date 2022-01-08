import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/views/authentication/login_screen.dart';
import 'package:skitoboxes/views/info/landing_page.dart';
import 'package:skitoboxes/views/splash/main_splash_screen.dart';

import '../../home_screen.dart';

class AuthDecider extends StatelessWidget {
  const AuthDecider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.getUserId(),
        builder: (ctx, AsyncSnapshot auth){
          if(auth.hasData && auth.data != null){
            authController.getUserById(auth.data);
            return const HomeScreen();
          }else{
            return LandingPage();
          }
        });
  }
}
