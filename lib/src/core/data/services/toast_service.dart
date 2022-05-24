import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';

class ToastService {
  ToastService._();

  static Future<void> showToast(String message) async {
    if (Platform.isAndroid) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.black87,
        fontSize: 14,
      );
    } else {
      return showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text(Localization.ok.tr),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      );
    }
  }
}
