import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/common/botnavbar.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/login/data_widget/text_field_name_widget.dart';
import 'package:mono_management/src/core/ui/notes/note_form_controller.dart';
import 'package:mono_management/src/util/ui/ui_utils.dart';

class NoteFormView extends GetView<NoteFormController> {
  const NoteFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteFormController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Створення',
          ),
          backgroundColor: appBarColor,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: UniqueKey(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldNameWidget(name: 'Заголовок'),
                TextFormField(
                  // controller: controller.emailTEC,
                  // validator: Utils.emailValidator,
                  style: GoogleFonts.roboto(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: UiUtils.loginTextFieldInputBorder,
                    focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                    enabledBorder: UiUtils.loginTextFieldInputBorder,
                    errorBorder: UiUtils.loginTextFieldErrorBorder,
                    fillColor: colorAccent,
                    focusColor: colorAccent,
                    hintText: 'Введіть заголовок записки',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldNameWidget(name: 'Вміст записки'),
                TextFormField(
                  // controller: controller.passwordTEC,
                  // obscureText: controller.passwordObscureText,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: Utils.passwordValidator,
                  style: GoogleFonts.roboto(),
                  maxLines: 20,
                  decoration: InputDecoration(
                    border: UiUtils.loginTextFieldInputBorder,
                    focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                    enabledBorder: UiUtils.loginTextFieldInputBorder,
                    errorBorder: UiUtils.loginTextFieldErrorBorder,
                    hintText: 'Введіть вміст записки',
                    // errorText: controller.passwordError,
                    // suffixIcon: passwordSuffixIcon(controller),
                  ),
                  onChanged: (val) {},
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: (){print('saved');}, child: const Text('Зберегти'))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
