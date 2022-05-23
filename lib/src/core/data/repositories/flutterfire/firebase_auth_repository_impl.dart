import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';
import 'package:mono_management/src/core/ui/dialogs/confirmation_dialog.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  FirebaseAuthRepositoryImpl();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  User? getFirebaseUser() => firebaseAuth.currentUser;

  @override
  Future<void> signOut() async {
    final bool? canSignOut = await Get.dialog(
      ConfirmationDialog(
        question: Localization.logoutQuestion.tr,
      ),
    );
    if (canSignOut == true) {
      return firebaseAuth.signOut();
    }
  }

  @override
  Future<void> registerAuthStateListener() async {
    firebaseAuth.authStateChanges().listen((event) {
      if (event == null) {
        if (!Routes.isLogoutRoute(Get.currentRoute)) {
          Get.offNamed(Routes.loginRoute);
        }
        debugPrint('User is currently signed out!');
      }
    });
  }

  @override
  Future<UserCredential> createAccountWithEmailAndPassword(
          String email, String password) =>
      firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

  @override
  Future<UserCredential> loginWithEmailAndPassword(
          String email, String password) =>
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
}
