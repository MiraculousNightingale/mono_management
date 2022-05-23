import 'package:get/get.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 1));
    return _checkUserIsLogged();
  }

  void _checkUserIsLogged() {
    final FirebaseAuthRepository firebaseAuthRepository =
        Get.find<FirebaseAuthRepository>();
    firebaseAuthRepository.registerAuthStateListener();
    if (firebaseAuthRepository.getFirebaseUser() == null) {
      Get.offNamed(Routes.loginRoute);
    } else {
      Get.offNamed(Routes.homeRoute);
    }
  }
}
