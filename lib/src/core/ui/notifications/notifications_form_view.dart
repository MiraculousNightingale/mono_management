import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/common/botnavbar.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/login/data_widget/text_field_name_widget.dart';
import 'package:mono_management/src/core/ui/notifications/notifications_form_controller.dart';
import 'package:mono_management/src/util/ui/ui_utils.dart';

class NotificationFormView extends GetView<NotificationsFormController> {
  const NotificationFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsFormController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Створення оповіщення',
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
                TextFieldNameWidget(name: 'Тип оповіщення'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: const [true, false, false],
                      children: const [
                        SizedBox(
                          width: 110,
                          child: Center(
                            child: Text(
                              'По балансу',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Center(
                            child: Text(
                              'По курсу',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Center(
                            child: Text(
                              'По даті',
                            ),
                          ),
                        ),
                      ],
                      onPressed: (index) {
                        //TODO: sensitive to Enum elements declaration order, change?
                        //switch/if doesn't matter still the same
                        //might change ToggleButtons to smth else
                        // controller.filterStatementType = StatementOperationType.values[index];
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldNameWidget(name: 'Рахунок'),
                Row(children: [Expanded(child: DropdownButton<String>(items: [DropdownMenuItem(child: Text('537541******2242'))], onChanged: (object) {}))]),
                const SizedBox(
                  height: 15,
                ),
                TextFieldNameWidget(name: 'Ліміт'),
                TextFormField(
                  // controller: controller.passwordTEC,
                  // obscureText: controller.passwordObscureText,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: Utils.passwordValidator,
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    border: UiUtils.loginTextFieldInputBorder,
                    focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                    enabledBorder: UiUtils.loginTextFieldInputBorder,
                    errorBorder: UiUtils.loginTextFieldErrorBorder,
                    hintText: 'Введіть значення балансу',
                    // errorText: controller.passwordError,
                    // suffixIcon: passwordSuffixIcon(controller),
                  ),
                  onChanged: (val) {},
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldNameWidget(name: 'Тип порівняння'),
                Row(children: [Expanded(child: DropdownButton<String>(items: [DropdownMenuItem(child: Text('Більше'))], onChanged: (object) {}))]),
                const SizedBox(
                  height: 15,
                ),
                TextFieldNameWidget(name: 'Текст оповіщення'),
                TextFormField(
                  // controller: controller.passwordTEC,
                  // obscureText: controller.passwordObscureText,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: Utils.passwordValidator,
                  style: GoogleFonts.roboto(),
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: UiUtils.loginTextFieldInputBorder,
                    focusedBorder: UiUtils.loginTextFieldFocusedBorder,
                    enabledBorder: UiUtils.loginTextFieldInputBorder,
                    errorBorder: UiUtils.loginTextFieldErrorBorder,
                    hintText: 'Введіть текст оповіщення',
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
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              print('saved');
                            },
                            child: const Text('Зберегти'))),
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
