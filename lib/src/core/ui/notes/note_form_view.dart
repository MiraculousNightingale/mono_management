import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/common/botnavbar.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/notes/note_form_controller.dart';

class NoteFormView extends GetView<NoteFormController>{
  const NoteFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteFormController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            Localization.editing.tr,
          ),
          backgroundColor: appBarColor,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: Center(child: Text('cock'),),
      ),
    );
  }

}