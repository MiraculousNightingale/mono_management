import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  String? _error;

  String? get error => _error;

  set error(String? value) {
    _error = value;
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

  Future<void> onLogin() async {
    ///TODO: Handle errors
    if (formKey.currentState!.validate()) {
      final FirebaseAuthRepository firebaseAuthRepository =
          Get.find<FirebaseAuthRepository>();
      await firebaseAuthRepository.loginWithEmailAndPassword(
        emailTEC.text,
        passwordTEC.text,
      );
      if (firebaseAuthRepository.getFirebaseUser() != null) {
        Get.offNamed(Routes.homeRoute);
      }
    }
  }

  void onRegistrationTap() => Get.offNamed(Routes.registrationRoute);

  void onFieldChanged(String value) {
    if (error != null) {
      error = null;
    }
  }
}
