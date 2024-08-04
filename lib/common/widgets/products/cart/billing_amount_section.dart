import 'package:flutter/material.dart';

import '../../../../utils/contants/sizes.dart';
import '../../../../utils/helpers/pricing_calculator.dart';

class MBillingAmountSection extends StatelessWidget {
  const MBillingAmountSection({super.key, required this.subTotal});

  final double subTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// -- Sub Total
        Row(
          children: [
            Expanded(
                child: Text('Tổng tiền sản phẩm',
                    style: Theme.of(context).textTheme.bodyMedium)),
            Text(MPricingCalculator.toPrice(subTotal),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),

        /// -- Shipping Fee
        Row(
          children: [
            Expanded(
                child: Text('Phí vận chuyển',
                    style: Theme.of(context).textTheme.bodyMedium)),
            Text(
              MPricingCalculator.calculateShippingCost(subTotal, 'VND'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),

        /// -- Tax Fee
        Row(
          children: [
            Expanded(
                child: Text('Thuế',
                    style: Theme.of(context).textTheme.bodyMedium)),
            Text(
              MPricingCalculator.calculateTax(subTotal, 'VND'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems),

        /// -- Order Total
        Row(
          children: [
            Expanded(
                child: Text('Tổng hóa đơn',
                    style: Theme.of(context).textTheme.titleMedium)),
            Text(
              MPricingCalculator.toPrice(
                  MPricingCalculator.calculateTotalPrice(subTotal, 'VND')),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
