import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/enums.dart';
import '../../../../utils/contants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        // If the product have variations then show the product Details for variation selection.
        // ELse add product to the cart.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(
        () {
          final productQuantityInCart =
              cartController.getProductQuantityInCart(product.id);
          return AnimatedContainer(
            curve: Curves.easeInOutCubicEmphasized,
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? MColors.primary : MColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MSizes.cardRadiusMd),
                bottomRight: Radius.circular(MSizes.productImageRadius),
              ),
            ),
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: MSizes.iconLg * 1.2,
              height: MSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(productQuantityInCart.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: MColors.white))
                    : const Icon(Iconsax.add, color: MColors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
