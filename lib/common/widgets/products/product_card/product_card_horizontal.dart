import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/enums.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';
import '../favourite_icon/favourite_icon.dart';
import 'product_card_add_to_cart_button.dart';

class MProductCardHorizontal extends StatelessWidget {
  const MProductCardHorizontal(
      {super.key, required this.product, this.isNetworkImage = true});

  final ProductModel product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);
    final salePercentage = ProductController.instance
        .calculateSalePercentage(product.price, product.salePrice);

    /// Container with side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MSizes.productImageRadius),
          color: MHelperFunctions.isDarkMode(context)
              ? MColors.darkerGrey
              : MColors.lightContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            MRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(MSizes.sm),
              backgroundColor: isDark ? MColors.dark : MColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  MRoundedImage(
                      width: 120,
                      height: 120,
                      imageUrl: product.thumbnail,
                      isNetworkImage: isNetworkImage),

                  /// -- Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      left: 0,
                      child: MRoundedContainer(
                        backgroundColor: isDark
                            ? MColors.secondary.withOpacity(0.8)
                            : MColors.secondary.withOpacity(0.8),
                        radius: MSizes.sm,
                        padding: const EdgeInsets.symmetric(
                            horizontal: MSizes.sm, vertical: MSizes.xs),
                        child: Text('$salePercentage%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: MColors.black)),
                      ),
                    ),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: MFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MSizes.spaceBtwItems / 2),

            /// -- Details, Add to Cart, & Pricing
            Container(
              padding: const EdgeInsets.only(left: MSizes.sm),
              width: 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Details
                  Padding(
                    padding: const EdgeInsets.only(top: MSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MProductTitleText(
                          title: product.title,
                          smallSize: true,
                          maxLines: 2,
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems / 2),
                        MBrandTitleWithVerifiedIcon(
                            title: product.brand!.name,
                            brandTextSize: TextSizes.small),
                      ],
                    ),
                  ),

                  /// Price & Add to cart button
                  /// Use Spacer() to utilize all the space and set the price and cart button at the bottom.
                  /// This usually happens when Product title is in single line or 2 lines (Max)
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Actual Price if sale price not null
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)

                              /// Format tiền Việt
                              Padding(
                                padding: const EdgeInsets.only(left: MSizes.sm),
                                child: Text(
                                  MPricingCalculator.toPrice(product.price),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              ),

                            /// Price, Show sale price as main price if sale exist.
                            Padding(
                              padding: const EdgeInsets.only(left: MSizes.sm),
                              child: product.salePrice > 0
                                  ? Text(
                                      MPricingCalculator.toPrice(
                                          product.salePrice),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      MPricingCalculator.toPrice(product.price),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              // child: TProductPriceText(price: ProductController.instance.getProductPrice(product)),
                            ),
                          ],
                        ),
                      ),

                      /// Add to cart
                      ProductCardAddToCartButton(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
