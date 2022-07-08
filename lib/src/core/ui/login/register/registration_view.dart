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

import 'registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        fillColor: colorAccent,
                        focusColor: colorAccent,
                        hintText: Localization.enterEmail.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldNameWidget(name: Localization.password.tr),
                    TextFormField(
                      controller: controller.passwordTEC,
                      obscureText: controller.passwordObscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Utils.passwordValidator,
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        hintText: Localization.password.tr,
                        errorText: controller.passwordError,
                        suffixIcon: passwordSuffixIcon(controller),
                      ),
                      onChanged: controller.onPasswordChanged,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldNameWidget(name: Localization.confirmPassword.tr),
                    TextFormField(
                      controller: controller.confirmPasswordTEC,
                      obscureText: controller.passwordObscureText,
                      validator: Utils.passwordValidator,
                      style: GoogleFonts.roboto(),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        hintText: Localization.confirmPassword.tr,
                        errorText: controller.passwordError,
                        suffixIcon: passwordSuffixIcon(controller),
                      ),
                      onChanged: controller.onPasswordChanged,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldNameWidget(name: 'АРІ ключ'),
                    TextFormField(
                      controller: controller.emailTEC,
                      validator: Utils.emailValidator,
                      style: GoogleFonts.roboto(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UiUtils.loginTextFieldInputBorder,
                        focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                        enabledBorder: UiUtils.loginTextFieldInputBorder,
                        errorBorder: UiUtils.loginTextFieldErrorBorder,
                        fillColor: colorAccent,
                        focusColor: colorAccent,
                        hintText: 'Введіть АРІ ключ',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: UiUtils.defaultButtonStyle,
                      onPressed: controller.onRegister,
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: Text(
                            Localization.createAccount.tr,
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
                  text: '${Localization.alreadyHaveAccount.tr} ',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: Localization.login.tr,
                      style: GoogleFonts.roboto(
                        color: colorAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onLoginPageTap,
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

  Widget passwordSuffixIcon(RegistrationController controller) {
    return IconButton(
      onPressed: () {
        controller.passwordObscureText = !controller.passwordObscureText;
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
    );
  }
}
