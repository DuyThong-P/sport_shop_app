import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/billing_amount_section.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loader.dart';
import '../../controllers/dummy_data.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    // final totalAmount = MPricingCalculator.toPrice(subTotal);
    final totalAmount = MPricingCalculator.calculateTotalPrice(subTotal, 'VND');
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MAppBar(title: Text('Đơn hàng'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -- Items in Cart
              const MCartItems(showAddRemoveButtons: false),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// -- Coupon TextField
              const MCouponCode(),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// -- Billing Section
              MRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(MSizes.md),
                backgroundColor: dark ? MColors.black : MColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    MBillingAmountSection(subTotal: subTotal),
                    const SizedBox(height: MSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: MSizes.spaceBtwItems),

                    /// Payment Methods
                    const MBillingPaymentSection(),
                    const SizedBox(height: MSizes.spaceBtwSections),

                    /// Address
                    MBillingAddressSection(
                      name: MDummyData.user.fullName,
                      phoneNumber: MDummyData.user.formattedPhoneNo,
                      address: MDummyData.user.addresses.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => MLoaders.warningSnackBar(
                    title: 'Giỏ hàng trống',
                    message: 'Thêm các mặt hàng vào giỏ hàng để tiếp tục.'),
            child: const Text('Thanh toán'),
          ),
        ),
      ),
    );
  }
}
