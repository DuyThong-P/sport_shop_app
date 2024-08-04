import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_text_with_verified_icon.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/enums.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class MProductMetaData extends StatelessWidget {
  const MProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = ProductController.instance
        .calculateSalePercentage(product.price, product.salePrice);
    final darkMode = MHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// -- Sale Tag
            if (salePercentage != null)
              Row(
                children: [
                  MRoundedContainer(
                    backgroundColor: MColors.secondary,
                    radius: MSizes.sm,
                    padding: const EdgeInsets.symmetric(
                        horizontal: MSizes.sm, vertical: MSizes.xs),
                    child: Text('$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: MColors.black)),
                  ),
                  const SizedBox(width: MSizes.spaceBtwItems)
                ],
              ),

            // Actual Price if sale price not null.
            if ((product.productVariations == null ||
                    product.productVariations!.isEmpty) &&
                product.salePrice > 0.0)
              // Format tien Viet gia goc
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: MSizes.sm),
                    child: Text(
                      MPricingCalculator.toPrice(product.price),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ],
              ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(product.price.toString(), style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            //     const SizedBox(width: MSizes.spaceBtwItems)
            //   ],
            // ),

            // Price, Show sale price as main price if sale exist.
            // TProductPriceText(price: controller.getProductPrice(product), isLarge: true),
            // Format Tien Viet gia ban
            Padding(
              padding: const EdgeInsets.only(left: MSizes.sm),
              child: product.salePrice > 0
                  ? Text(
                      MPricingCalculator.toPrice(product.salePrice),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      MPricingCalculator.toPrice(product.price),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              // child: MProductPriceText(price: ProductController.instance.getProductPrice(product)),
            )
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 1.5),
        MProductTitleText(title: product.title),
        const SizedBox(height: MSizes.spaceBtwItems / 1.5),

        Row(
          children: [
            Text(
              product.stock != 'In Stock' ? 'Còn Hàng' : 'Hết Hàng',
              style: TextStyle(
                color: product.stock != 'In Stock' ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        // const MProductTitleText(title: 'Tồn kho : ', smallSize: true),
        // Text(controller.getProductStockStatus(product), style: Theme.of(context).textTheme.titleMedium),
        // const SizedBox(height: MSizes.spaceBtwItems / 2),

        /// Brand
        Row(
          children: [
            MCircularImage(
              image: product.brand!.image,
              width: 34,
              height: 34,
              overlayColor: darkMode ? MColors.white : MColors.black,
            ),
            MBrandTitleWithVerifiedIcon(
                title: product.brand!.name, brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
