import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler._();

  static const String wrongPasswordCode = 'wrong-password';

  static String handleFirebaseAuthException(Object exception){
    if(exception is FirebaseAuthException){
      return firebaseErrorToString(exception.code);
    }
    return Localization.unexpectedError.tr;
  }

  static String firebaseErrorToString(String errorCode) {
    switch (errorCode) {
      case wrongPasswordCode:
        return Localization.wrongPassword.tr;
      default:
        return Localization.unexpectedError.tr;
    }
  }
}
