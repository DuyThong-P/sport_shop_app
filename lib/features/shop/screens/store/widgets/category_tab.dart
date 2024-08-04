import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/categories_controller.dart';
import '../../../models/category_model.dart';
import '../../all_products/all_products.dart';
import 'category_brands.dart';

class MCategoryTab extends StatelessWidget {
  const MCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Category Brands
              CategoryBrands(category: category),
              const SizedBox(height: MSizes.spaceBtwSections * 1),

              /// -- Category Products You May Like
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  /// Helper Function: Handle Loader, No Record, OR ERROR Message
                  final response = MCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: const MVerticalProductShimmer());
                  if (response != null) return response;

                  /// Record Found!
                  final products = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MSectionHeading(
                        title: 'Gợi ý cho bạn',
                        showActionButton: true,
                        onPressed: () => Get.to(AllProducts(
                          title: category.name,
                          futureMethod: controller.getCategoryProducts(
                              categoryId: category.id, limit: -1),
                        )),
                      ),
                      const SizedBox(height: MSizes.spaceBtwItems),
                      MGridLayout(
                        itemCount: products.length < 4 ? products.length : 4,
                        itemBuilder: (_, index) => MProductCardVertical(
                            product: products[index], isNetworkImage: true),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
