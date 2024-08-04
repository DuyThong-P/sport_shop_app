import 'package:flutter/material.dart';
import '../../../utils/contants/sizes.dart';
import 'shimmer.dart';

class MSearchCategoryShimmer extends StatelessWidget {
  const MSearchCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (_, __) =>
            const SizedBox(width: MSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              MShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: MSizes.spaceBtwItems / 2),

              /// Text
              MShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
