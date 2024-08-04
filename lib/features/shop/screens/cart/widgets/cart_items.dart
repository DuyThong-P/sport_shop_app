import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../controllers/product/cart_controller.dart';

class MCartItems extends StatelessWidget {
  const MCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final cartItems = cartController.cartItems;
    return Obx(
      () {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: cartItems.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) =>
              const SizedBox(height: MSizes.spaceBtwSections),
          itemBuilder: (context, index) {
            return Obx(
              () {
                final item = cartItems[index];
                return Column(
                  children: [
                    /// -- Cart Items
                    MCartItem(item: item),
                    if (showAddRemoveButtons)
                      const SizedBox(height: MSizes.spaceBtwItems),

                    /// -- Add Remove Buttons and Price Total
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// -- Add Remove Buttons
                          Row(
                            children: [
                              // Use to add space to the left of Buttons as image space.
                              const SizedBox(width: 70),

                              /// Add Remove Buttons
                              MProductQuantityWithAddRemoveButton(
                                width: 32,
                                height: 32,
                                iconSize: MSizes.md,
                                quantity: item.quantity,
                                addBackgroundColor: MColors.primary,
                                removeForegroundColor:
                                    MHelperFunctions.isDarkMode(context)
                                        ? MColors.white
                                        : MColors.black,
                                removeBackgroundColor:
                                    MHelperFunctions.isDarkMode(context)
                                        ? MColors.darkerGrey
                                        : MColors.light,
                                add: () => cartController.addOneToCart(item),
                                remove: () =>
                                    cartController.removeOneFromCart(item),
                              ),
                            ],
                          ),

                          /// -- Product total price
                          /// Tính giá tiền sản phẩm giỏ hàng
                          Text(
                            MPricingCalculator.toPrice(
                                (item.price * item.quantity)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )

                          // TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                        ],
                      )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
