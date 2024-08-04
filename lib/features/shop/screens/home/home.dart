import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/contants/text_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';
import 'widgets/home_categories.dart';
import 'widgets/header_search_container.dart';
import 'widgets/home_appbar.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const MPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Appbar
                  THomeAppBar(),
                  SizedBox(height: MSizes.spaceBtwSections),

                  /// -- Searchbar
                  MSearchContainer(
                      text: 'Tìm kiếm sản phẩm', showBorder: false),
                  SizedBox(height: MSizes.spaceBtwSections),

                  /// -- Categories
                  MHomeCategories(),
                  SizedBox(height: MSizes.spaceBtwSections * 2),
                ],
              ),
            ),

            /// -- Body
            Container(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Promo Slider 1
                  const MPromoSlider(),
                  const SizedBox(height: MSizes.spaceBtwSections),

                  /// -- Popular Products
                  MSectionHeading(
                    title: MTexts.popularProducts,
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: MTexts.popularProducts,
                        futureMethod:
                            ProductRepository.instance.getAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),

                  Obx(
                    () {
                      // Check if categories are still loading
                      if (controller.isLoading.value) {
                        return const MVerticalProductShimmer();
                      }

                      // Check if there are no featured categories found
                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                            child: Text('No Data Found!',
                                style: Theme.of(context).textTheme.bodyMedium));
                      } else {
                        /// Record Found! 🎊
                        return MGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => MProductCardVertical(
                              product: controller.featuredProducts[index],
                              isNetworkImage: true),
                        );
                      }
                    },
                  ),

                  SizedBox(
                      height: MDeviceUtils.getBottomNavigationBarHeight() +
                          MSizes.defaultSpace),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
