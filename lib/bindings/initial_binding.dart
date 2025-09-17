import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../module/auth/controller/auth_controller.dart';
import '../module/auth/service/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    print("AuthService & AuthController registered");
  }
}
