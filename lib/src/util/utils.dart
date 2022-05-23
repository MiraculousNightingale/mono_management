import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';

class Utils {
  Utils._();

  static String? emailValidator(String? value) {
    if (value == null) return null;
    value = value.trim();
    if (value.isEmpty) {
      return Localization.emptyFieldValidator.tr;
    } else if (!GetUtils.isEmail(value)) {
      return Localization.emailValidator.tr;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null) return null;
    value = value.trim();
    if (value.isEmpty) {
      return Localization.emptyFieldValidator.tr;
    } else if (value.length < 8) {
      return Localization.passwordValidator.tr;
    }
    return null;
  }
}
