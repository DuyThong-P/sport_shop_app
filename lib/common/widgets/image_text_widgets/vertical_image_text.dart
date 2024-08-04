import 'package:flutter/material.dart';

import '../../../utils/contants/colors.dart';
import '../../../utils/contants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../images/circular_image.dart';
import '../texts/brand_title_text_shadown.dart';

class MVerticalImageText extends StatelessWidget {
  const MVerticalImageText({
    Key? key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = MColors.black,
  }) : super(key: key);

  final String image;
  final String title;
  final Color textColor;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MSizes.spaceBtwItems),
        child: Column(
          children: [
            MCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: MSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: MHelperFunctions.isDarkMode(context)
                  ? MColors.light
                  : MColors.dark,
            ),
            const SizedBox(height: MSizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: MBrandTitleTextShadown(title: title, color: textColor)),
          ],
        ),
      ),
    );
  }
}
