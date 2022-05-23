import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {Key? key, this.confirmationText, this.question = '', this.rejectText})
      : super(key: key);

  final String question;
  final String? confirmationText;
  final String? rejectText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        question,
        textAlign: TextAlign.center,
      ),
      actions: [
        _buildButton(
          rejectText ?? Localization.yes.tr,
          () {
            Get.back(
              result: true,
            );
          },
        ),
        _buildButton(
          rejectText ?? Localization.no.tr,
          Get.back,
          isConfirmation: true,
        ),
      ],
    );
  }

  InkWell _buildButton(String text, GestureTapCallback? onTap,
          {bool isConfirmation = false}) =>
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontWeight: isConfirmation ? FontWeight.w500 : FontWeight.w400,
              fontSize: 16,
              color: colorAccent,
            ),
          ),
        ),
      );
}
