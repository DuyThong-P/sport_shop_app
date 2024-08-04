import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/all_products_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../layouts/grid_layout.dart';
import '../product_card/product_card_vertical.dart';

class MSortableProducts extends StatelessWidget {
  const MSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) => controller.sortProducts(value!),
          value: controller.selectedSortOption.value,
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              // items: ['Tên', 'Giá cao nhất', 'Giá thấp nhất', 'Giảm giá', 'Mới nhất', 'Phổ biến']
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: MSizes.spaceBtwSections),
        Obx(
          () => MGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => MProductCardVertical(
                product: controller.products[index], isNetworkImage: true),
          ),
        ),
        SizedBox(
            height: MDeviceUtils.getBottomNavigationBarHeight() +
                MSizes.defaultSpace),
      ],
    );
  }
}
