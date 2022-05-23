import 'package:flutter/material.dart';
import 'package:mono_management/resources/colors.dart';

class UiUtils {
  UiUtils._();

  static BorderRadius inputBorderRadius = BorderRadius.circular(10);

  static OutlineInputBorder loginTextFieldInputBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: const BorderSide(
      color: colorAccent,
    ),
  );

  static OutlineInputBorder loginTextFieldFocusedBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: const BorderSide(
      width: 2,
      color: colorAccent,
    ),
  );

  static OutlineInputBorder loginTextFieldErrorBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: const BorderSide(
      color: colorError,
    ),
  );

  static ButtonStyle defaultButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(colorAccent),
  );
}
