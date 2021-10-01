import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/authentication/auth_controller.dart';
import 'package:skitoboxes/controllers/navigation/navigation_controller.dart';
import 'package:skitoboxes/controllers/order_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/theme/app_theme.dart';
import 'controllers/authentication/auth_data_handling_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // INITIALIZING IMPORTANT GET X CONTROLLERS
  Get.put(NavigationController());
  Get.put(AuthController());
  Get.put(
    AuthDataHandlingController(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      defaultTransition: Transition.zoom,
      onGenerateRoute: RouteGenerator.onGeneratedRoutes,
      navigatorKey: navigationController.navigationKey,
    );
  }
}
