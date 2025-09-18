// short & focused: UI-only (Form + buttons)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';

import '../../../constants/route_constants.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController auth = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.login)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: TextConstants.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || v.isEmpty
                        ? TextConstants.emailValidation
                        : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      labelText: TextConstants.password,
                    ),
                    obscureText: true,
                    validator: (v) => v == null || v.length < 6
                        ? TextConstants.passwordValidation
                        : null,
                  ),
                  SizedBox(height: 18),
                  Obx(() {
                    if (auth.isLoading.value) {
                      return CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            auth.loginSignup(
                              emailController.text.trim(),
                              passController.text,
                              true,
                            );
                          }
                        },
                        child: Text(TextConstants.login),
                      ),
                    );
                  }),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.register),
                    child: Text(TextConstants.createAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
