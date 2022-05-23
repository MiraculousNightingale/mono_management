import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';

class RegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();

  String? _emailError;

  String? get emailError => _emailError;

  set emailError(String? value) {
    _emailError = value;
    update();
  }

  String? _passwordError;

  String? get passwordError => _passwordError;

  set passwordError(String? value) {
    _passwordError = value;
    update();
  }

  bool _passwordObscureText = true;

  bool get passwordObscureText => _passwordObscureText;

  set passwordObscureText(bool value) {
    if (value != _passwordObscureText) {
      _passwordObscureText = value;
      update();
    }
  }

  void onPasswordChanged(String value) {
    if (passwordError != null) {
      passwordError = null;
    }
  }

  Future<void> onRegister() async {
    if (passwordTEC.text != confirmPasswordTEC.text) {
      passwordError = Localization.passwordMismatchValidator.tr;
      return;
    }
    if (formKey.currentState!.validate()) {
      final UserCredential userCredential =
          await Get.find<FirebaseAuthRepository>()
              .createAccountWithEmailAndPassword(
        emailTEC.text,
        passwordTEC.text,
      );
      if (userCredential.user != null) {
        Get.offNamed(Routes.homeRoute);
      }
    }
  }

  void onLoginPageTap() => Get.offNamed(Routes.loginRoute);
}
