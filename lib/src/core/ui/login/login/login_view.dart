import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/login/data_widget/app_logo_widget.dart';
import 'package:mono_management/src/core/ui/login/data_widget/text_field_name_widget.dart';
import 'package:mono_management/src/util/ui/ui_utils.dart';
import 'package:mono_management/src/util/utils.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MonoManagementLogo(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldNameWidget(name: Localization.email.tr),
                    TextFormField(
                      controller: controller.emailTEC,
                      validator: Utils.emailValidator,
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        fillColor: colorAccent,
                        focusColor: colorAccent,
                        hintText: Localization.enterEmail.tr,
                      ),
                      onChanged: controller.onFieldChanged,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldNameWidget(name: Localization.password.tr),
                    TextFormField(
                      controller: controller.passwordTEC,
                      style: GoogleFonts.roboto(),
                      obscureText: controller.passwordObscureText,
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        fillColor: colorAccent,
                        focusColor: colorAccent,
                        hintText: Localization.enterPassword.tr,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.passwordObscureText =
                                !controller.passwordObscureText;
                          },

                          ///TODO: change icons
                          icon: controller.passwordObscureText
                              ? const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: colorAccent,
                                )
                              : const Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: colorAccent,
                                ),
                        ),
                      ),
                      onChanged: controller.onFieldChanged,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: UiUtils.defaultButtonStyle,
                      onPressed: controller.onLogin,
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: Text(
                            Localization.login.tr,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  text: '${Localization.doNotHaveAccount.tr} ',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: Localization.signUpNow.tr,
                      style: GoogleFonts.roboto(
                        color: colorAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onRegistrationTap,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
