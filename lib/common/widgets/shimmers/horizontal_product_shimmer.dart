import 'package:flutter/material.dart';
import '../../../utils/contants/sizes.dart';
import 'shimmer.dart';

class MHorizontalProductShimmer extends StatelessWidget {
  const MHorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: MSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: MSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            MShimmerEffect(width: 120, height: 120),
            SizedBox(width: MSizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MSizes.spaceBtwItems / 2),
                MShimmerEffect(width: 160, height: 15),
                SizedBox(height: MSizes.spaceBtwItems / 2),
                MShimmerEffect(width: 110, height: 15),
                SizedBox(height: MSizes.spaceBtwItems / 2),
                MShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
