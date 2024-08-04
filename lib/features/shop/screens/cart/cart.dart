import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shop_app/navigation_menu.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/contants/image_strings.dart';
import '../../../../utils/contants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final cartItems = controller.cartItems;
    return Scaffold(
      appBar: MAppBar(
          showBackArrow: true,
          title: Text('Giỏ hàng',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: cartItems.isEmpty
          ? _buildEmptyCartWidget()
          : const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(MSizes.defaultSpace),
                child: MCartItems(),
              ),
            ),
      bottomNavigationBar:
          cartItems.isNotEmpty ? _buildCheckoutButton() : SizedBox(),
    );
  }

  Widget _buildEmptyCartWidget() {
    return MAnimationLoaderWidget(
      text: 'Chưa có gì trong giỏ hàng của bạn..',
      animation: MImages.cartAnimation,
      showAction: true,
      actionText: 'Thêm vào nhé',
      onActionPressed: () => Get.off(() => const NavigationMenu()),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(MSizes.defaultSpace),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: const Text('Thanh toán'),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     final controller = CartController.instance;
//     final cartItems = controller.cartItems;
//     return Scaffold(
//       /// -- AppBar
//       appBar: MAppBar(showBackArrow: true, title: Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineSmall)),
//       body: Obx(() {
//         /// Nothing Found Widget
//         final emptyWidget = MAnimationLoaderWidget(
//           text: 'Chưa có gì trong giỏ hàng của bạn..',
//           animation: MImages.cartAnimation,
//           showAction: true,
//           actionText: 'Thêm vào nhé',
//           onActionPressed: () => Get.off(() => const HomeMenu()),
//         );
//
//         /// Cart Items
//         return cartItems.isEmpty
//             ? emptyWidget
//             : const SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(MSizes.defaultSpace),
//
//                   /// -- Items in Cart
//                   child: MCartItems(),
//                 ),
//               );
//       }),
//
//       /// -- Checkout Button
//       bottomNavigationBar: Obx(
//         () {
//           return cartItems.isNotEmpty
//               ? Padding(
//                   padding: const EdgeInsets.all(MSizes.defaultSpace),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => Get.to(() => const CheckoutScreen()),
//                       child: Obx(() => const Text('Thanh toán')),
//                     ),
//                   ),
//                 )
//               : const SizedBox();
//         },
//       ),
//     );
//   }
// }
