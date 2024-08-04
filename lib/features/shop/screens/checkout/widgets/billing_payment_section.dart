import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/checkout_controller.dart';

class MBillingPaymentSection extends StatelessWidget {
  const MBillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        MSectionHeading(
          title: 'Phương thức thanh toán',
          buttonTitle: 'thay đổi',
          showActionButton: true,
          onPressed: () {
            controller.selectPaymentMethod(context);
          },
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              MRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: MHelperFunctions.isDarkMode(context)
                    ? MColors.light
                    : MColors.white,
                padding: const EdgeInsets.all(MSizes.sm),
                child: Image(
                    image: AssetImage(
                        controller.selectedPaymentMethod.value.image),
                    fit: BoxFit.contain),
              ),
              const SizedBox(width: MSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
