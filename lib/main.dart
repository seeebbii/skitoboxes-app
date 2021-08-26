import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // INITIALIZING IMPORTANT GET X CONTROLLERS
  Get.put(NavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline5: TextStyle(
            fontFamily: 'Akira',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        primarySwatch: MaterialColor(0xFFFFB703, color),
        primaryColor: yellow,
        accentColor: darkBlue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: blue,
        dividerColor: lightBlue,
        focusColor: yellow,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: darkBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: orange,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: orange,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      defaultTransition: Transition.zoom,
      onGenerateRoute: RouteGenerator.onGeneratedRoutes,
      navigatorKey: navigationController.navigationKey,
    );
  }
}
