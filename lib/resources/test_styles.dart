import 'package:flutter/material.dart';

abstract class TextStyles {
  static const black14w600 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static const black14w400 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}

abstract class ButtonStyles {
  static final bgRedTxWhite = ElevatedButton.styleFrom(
    primary: Colors.red,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
  );
  static final bgGreenTxWhite = ElevatedButton.styleFrom(
    primary: Colors.green,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
  );
  static final bgGreyTxWhite = ElevatedButton.styleFrom(
    primary: Colors.grey,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
  );
  static final toggled = ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black,
    side: const BorderSide(),
  );
}
