import 'package:flutter/material.dart';

import '../../contants/colors.dart';
import '../../contants/sizes.dart';

class MOutlinedButtonTheme {
  MOutlinedButtonTheme._();

  //* -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: MColors.dark,
      side: const BorderSide(color: MColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: MColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: MSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );

  //* -- Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: MColors.light,
      side: const BorderSide(color: MColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: MColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: MSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MSizes.buttonRadius)),
    ),
  );
}
