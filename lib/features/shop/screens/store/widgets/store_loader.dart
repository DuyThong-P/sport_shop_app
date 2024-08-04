import 'package:flutter/material.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/contants/sizes.dart';

class MStoreShimmerLoader extends StatelessWidget {
  const MStoreShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(height: MSizes.spaceBtwSections),
            // AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MShimmerEffect(width: 100, height: 15),
                MShimmerEffect(width: 55, height: 55, radius: 55),
              ],
            ),
            SizedBox(height: MSizes.spaceBtwSections * 2),
            // Search
            MShimmerEffect(width: double.infinity, height: 55),
            SizedBox(height: MSizes.spaceBtwSections),

            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MShimmerEffect(width: 100, height: 15),
                MShimmerEffect(width: 80, height: 12),
              ],
            ),
            SizedBox(height: MSizes.spaceBtwSections),

            // Brands
            MBrandsShimmer(),
            SizedBox(height: MSizes.spaceBtwSections * 2),

            // Categories
            Row(
              children: [
                Expanded(child: MShimmerEffect(width: 100, height: 15)),
                SizedBox(width: MSizes.spaceBtwItems),
                Expanded(child: MShimmerEffect(width: 100, height: 15)),
                SizedBox(width: MSizes.spaceBtwItems),
                Expanded(child: MShimmerEffect(width: 100, height: 15)),
                SizedBox(width: MSizes.spaceBtwItems),
                Expanded(child: MShimmerEffect(width: 100, height: 15)),
              ],
            ),
            SizedBox(height: MSizes.spaceBtwSections),

            // Category Brands
            MListTileShimmer(),
            SizedBox(height: MSizes.spaceBtwSections),
            MBoxesShimmer(),
            SizedBox(height: MSizes.spaceBtwSections),

            // Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MShimmerEffect(width: 100, height: 15),
                MShimmerEffect(width: 80, height: 12),
              ],
            ),
            SizedBox(height: MSizes.spaceBtwSections),

            MVerticalProductShimmer(),
            SizedBox(height: MSizes.spaceBtwSections * 3),
          ],
        ),
      ),
    );
  }
}
