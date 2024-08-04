import 'package:flutter/material.dart';

import '../../utils/contants/colors.dart';

class MShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: MColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
