import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';
import 'package:mono_management/src/core/data/services/toast_service.dart';
import 'package:mono_management/src/core/network/firebase_auth_exception_handler.dart';

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

  Future<void> onLogin() async {
    ///TODO: Handle errors
    if (passwordError != null) return;
    if (formKey.currentState!.validate()) {
      final FirebaseAuthRepository firebaseAuthRepository =
          Get.find<FirebaseAuthRepository>();
      try {
        await firebaseAuthRepository.loginWithEmailAndPassword(
          emailTEC.text,
          passwordTEC.text,
        );
        if (firebaseAuthRepository.getFirebaseUser() != null) {
          Get.offNamed(Routes.homeRoute);
        }
      } catch (err) {
        if (err is FirebaseAuthException) {
          if (err.code == FirebaseAuthExceptionHandler.wrongPasswordCode) {
            passwordError = Localization.wrongPassword.tr;
            ToastService.showToast(
              Localization.wrongPassword.tr,
            );
            return;
          }
        }
        ToastService.showToast(
            FirebaseAuthExceptionHandler.handleFirebaseAuthException(err));
      }
    }
  }

  void onRegistrationTap() => Get.offNamed(Routes.registrationRoute);

  void onFieldChanged(String value) {
    if (error != null) {
      error = null;
    }
  }

  void onPasswordFieldChanged(String value) {
    if (passwordError != null) {
      passwordError = null;
    }
  }
}
