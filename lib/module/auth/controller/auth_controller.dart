import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import 'package:isro_quiz_app/module/auth/model/user_model.dart';
import 'package:isro_quiz_app/module/auth/service/auth_service.dart';

import '../../../constants/route_constants.dart';

class AuthController extends GetxController {
  final AuthService _service = Get.find();
  var user = Rxn<UserModel>();
  var isLoading = false.obs;

  bool validation(String email, String password) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (email.isEmpty) {
      Get.snackbar(TextConstants.error, TextConstants.emailValidation);
      return false;
    }
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(TextConstants.error, TextConstants.validEmail);
      return false;
    }
    if (password.length < 6) {
      Get.snackbar(TextConstants.error, TextConstants.passwordValidation);
      return false;
    }
    return true;
  }

  Future<void> loginSignup(String email, String password, bool isLogin) async {
    if (!validation(email, password)) return;
    try {
      isLoading.value = false;
      var result = await _service.loginSignup(email, password, isLogin);
      if (result != null) Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar(
        isLogin ? TextConstants.loginFailed : TextConstants.registerFailed,
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
