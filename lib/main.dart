import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import 'package:isro_quiz_app/module/home/views/home_view.dart';
import 'bindings/initial_binding.dart';
import 'constants/route_constants.dart';
import 'module/auth/controller/auth_controller.dart';
import 'module/auth/views/login_view.dart';
import 'module/auth/views/registration_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("✅ Firebase Initialized");
  } catch (e) {
    print("❌ Firebase init failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TextConstants.appTitle,
      initialBinding: InitialBinding(),
      getPages: [
        GetPage(name: Routes.login, page: () => LoginView()),
        GetPage(name: Routes.register, page: () => RegisterView()),
        GetPage(name: Routes.home, page: () => HomeView()),
      ],
      home: Obx(() {
        final authController = Get.find<AuthController>();
        return authController.firebaseUser.value == null ? LoginView() : HomeView();
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
