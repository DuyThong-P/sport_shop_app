import 'package:flutter/material.dart';

import '../../../utils/contants/enums.dart';

class MBrandTitleTextShadown extends StatelessWidget {
  const MBrandTitleTextShadown({
    super.key,
    this.color,
    this.maxLines = 1,
    required this.title,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // Check which brandSize is required and set that style.
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(
              color: color,
              shadows: [
                Shadow(
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 6.0,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            )
          : brandTextSize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(
                  color: color,
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                )
              : brandTextSize == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(
                      color: color,
                      shadows: [
                        Shadow(
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    )
                  : Theme.of(context).textTheme.bodyMedium!.apply(
                      color: color,
                      shadows: [
                        Shadow(
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
    );
  }
}
