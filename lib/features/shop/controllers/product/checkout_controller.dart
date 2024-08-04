import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shop_app/utils/contants/image_strings.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/contants/sizes.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: MImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MSectionHeading(title: 'Chọn phương thức thanh toán'),
              const SizedBox(height: MSizes.spaceBtwSections),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: MImages.paypal)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: MImages.googlePay)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: MImages.applePay)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: MImages.visa)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: MImages.masterCard)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Paytm', image: MImages.paytm)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paystack', image: MImages.paystack)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              MPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: MImages.creditCard)),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
