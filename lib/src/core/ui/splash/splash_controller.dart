import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mono_management/firebase_options.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository_impl.dart';
import 'package:mono_management/src/core/network/dio_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;

  set packageInfo(PackageInfo? value) {
    _packageInfo = value;
    update();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    packageInfo = await PackageInfo.fromPlatform();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    DioManager.configure();
    _dependencies();
    await Future.delayed(const Duration(seconds: 1));
    return _checkUserIsLogged();
  }

  void _dependencies() {
    Get.lazyPut<FirebaseAuthRepository>(
          () => FirebaseAuthRepositoryImpl(),
      fenix: true,
    );
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

  String? getVersion() {
    if (packageInfo == null) return '';
    return 'v${packageInfo!.version} build (${packageInfo!.buildNumber})';
  }
}
