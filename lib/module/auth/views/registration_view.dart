import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import '../controller/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final AuthController auth = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.register)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailCtrl,
                    decoration: InputDecoration(labelText: TextConstants.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || v.isEmpty
                        ? TextConstants.emailValidation
                        : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passCtrl,
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
                    if (auth.isLoading.value)
                      return CircularProgressIndicator();
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            auth.loginSignup(
                              emailCtrl.text.trim(),
                              passCtrl.text,
                              false,
                            );
                          }
                        },
                        child: Text(TextConstants.register),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
