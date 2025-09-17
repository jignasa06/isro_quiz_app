import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import 'package:isro_quiz_app/views/home_view.dart';

import 'bindings/initial_binding.dart';
import 'constants/route_constants.dart';
import 'module/auth/views/login_view.dart';
import 'module/auth/views/registration_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TextConstants.appTitle,
      initialBinding: InitialBinding(),
      initialRoute: Routes.login,
      getPages: [
        GetPage(name: Routes.login, page: () => LoginView()),
        GetPage(name: Routes.register, page: () => RegisterView()),
        GetPage(name: Routes.home, page: () => HomeView()), // placeholder
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}