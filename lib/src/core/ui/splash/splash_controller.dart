import 'package:get/get.dart';
import 'package:mono_management/src/core/app_pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(Routes.homeRoute);
  }
}
