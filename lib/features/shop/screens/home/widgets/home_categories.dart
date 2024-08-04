import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../controllers/categories_controller.dart';
import '../../sub_category/sub_categories.dart';

/// A header widget displaying popular categories.
class MHomeCategories extends StatelessWidget {
  const MHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: MSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// -- Heading
          const MSectionHeading(
              title: 'Danh mục phổ biến',
              textColor: MColors.black,
              showActionButton: false),
          const SizedBox(height: MSizes.spaceBtwItems),

          /// Obx widget for reactive UI updates based on the state of [categoryController].
          /// It displays a shimmer loader while categories are being loaded, shows a message if no data is found,
          /// and renders a horizontal list of featured categories with images and text.
          Obx(
            () {
              // Check if categories are still loading
              if (categoryController.isLoading.value) {
                return const MCategoryShimmer();
              }

              // Check if there are no sub-categories found
              if (categoryController.featuredCategories.isEmpty) {
                return Center(
                    child: Text('Không tìm thấy dữ liệu!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: Colors.white)));
              } else {
                /// Data Found
                // Display a horizontal list of sub-categories with images and text
                return SizedBox(
                  height: 81,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.featuredCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final category =
                          categoryController.featuredCategories[index];
                      return MVerticalImageText(
                        title: category.name,
                        image: category.image,
                        onTap: () => Get.to(
                            () => SubCategoriesScreen(category: category)),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
