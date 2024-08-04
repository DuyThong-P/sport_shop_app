import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../common/widgets/shimmers/search_category_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../controllers/categories_controller.dart';
import '../../controllers/search_controller.dart';
import '../../models/category_model.dart';
import '../all_products/all_products.dart';
import '../brands/brand.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final categoryController = CategoryController.instance;
  final searchController = Get.put(TSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title:
            Text('Tìm kiếm', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Quay lại'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Search bar & Filter Button
              Row(
                children: [
                  /// Search
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (query) => searchController.searchProducts(
                          query,
                          sortingOption:
                              searchController.selectedSortingOption.value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.search_normal),
                          hintText: 'Tìm kiếm theo thương hiệu'),
                    ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwItems),

                  /// Filter
                  OutlinedButton(
                    onPressed: () => filterModalBottomSheet(context),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey)),
                    child: const Icon(Iconsax.setting, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Search
              Obx(
                () => searchController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    :
                    // Show search if not Empty
                    searchController.searchResults.isNotEmpty
                        ? MGridLayout(
                            itemCount: searchController.searchResults.length,
                            itemBuilder: (_, index) => MProductCardVertical(
                                product: searchController.searchResults[index]),
                          )
                        : brandsAndCategories(context),
              ),

              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  /// Brands & Categories Widget
  Column brandsAndCategories(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categoryController = Get.put(CategoryController());
    final isDark = MHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Brands Heading
        const MSectionHeading(
            title: 'Tất cả thương hiệu', showActionButton: false),

        /// -- Brands
        Obx(
          () {
            // Check if categories are still loading
            if (brandController.isLoading.value) {
              return const MCategoryShimmer();
            }

            /// Data Found
            return Wrap(
              children: brandController.allBrands
                  .map((brand) => GestureDetector(
                        onTap: () => Get.to(BrandScreen(brand: brand)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: MSizes.md),
                          child: MVerticalImageText(
                            image: brand.image,
                            title: brand.name,
                            isNetworkImage: true,
                            textColor: MHelperFunctions.isDarkMode(context)
                                ? MColors.white
                                : MColors.dark,
                            backgroundColor:
                                MHelperFunctions.isDarkMode(context)
                                    ? MColors.darkerGrey
                                    : MColors.light,
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: MSizes.spaceBtwSections),

        /// Categories
        const MSectionHeading(title: 'Theo danh mục', showActionButton: false),
        const SizedBox(height: MSizes.spaceBtwItems),

        /// Obx widget for reactive UI updates based on the state of [categoryController].
        /// It displays a shimmer loader while categories are being loaded, shows a message if no data is found,
        /// and renders a horizontal list of featured categories with images and text.
        Obx(
          () {
            // Check if categories are still loading
            if (categoryController.isLoading.value) {
              return const MSearchCategoryShimmer();
            }

            // Check if there are no featured categories found
            if (categoryController.allCategories.isEmpty) {
              return Center(
                  child: Text('No Data Found!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white)));
            } else {
              /// Data Found
              // Display a horizontal list of featured categories with images and text
              final categories = categoryController.allCategories;
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: MSizes.spaceBtwItems),
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () => Get.to(
                    () => AllProducts(
                      title: categories[index].name,
                      futureMethod: categoryController.getCategoryProducts(
                          categoryId: categories[index].id),
                    ),
                  ),
                  child: Row(
                    children: [
                      MCircularImage(
                        width: 25,
                        height: 25,
                        padding: 0,
                        isNetworkImage: true,
                        overlayColor: isDark ? MColors.white : MColors.dark,
                        image: categories[index].image,
                      ),
                      const SizedBox(width: MSizes.spaceBtwItems / 2),
                      Text(categories[index].name)
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Future<dynamic> filterModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: MSizes.defaultSpace,
          right: MSizes.defaultSpace,
          top: MSizes.defaultSpace,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MSectionHeading(title: 'Lọc', showActionButton: false),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Iconsax.close_square))
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections / 2),

              /// Sort
              Text('Sắp xếp theo',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MSizes.spaceBtwItems / 2),

              _buildSortingDropdown(),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Categories

              Text('Danh mục', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MSizes.spaceBtwItems),
              // _buildCategoryList(),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Sort by Radios
              Text('Giá', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          searchController.minPrice.value = double.parse(value),
                      decoration:
                          const InputDecoration(hintText: '\$ TỐI THIỂU'),
                    ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwItems),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          searchController.maxPrice.value = double.parse(value),
                      decoration: const InputDecoration(hintText: '\$ TỐI ĐA'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    searchController.search();
                    Get.back();
                  },
                  child: const Text('Áp dụng'),
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortingDropdown() {
    return Obx(
      () => DropdownButton<String>(
        value: searchController.selectedSortingOption.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            searchController.selectedSortingOption.value = newValue;
            searchController
                .search(); // Trigger the search when the sorting option changes
          }
        },
        items: searchController.sortingOptions
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  //
  // Widget _buildCategoryList() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: categoryController.allCategories.length,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return _buildCategoryTile(categoryController.allCategories[index]);
  //     },
  //   );
  // }

  // Widget _buildCategoryTile(CategoryModel category) {
  //   return category.parentId.isEmpty ? Obx(() => _buildParentCategoryTile(category)) : const SizedBox.shrink();
  // }

  Widget _buildParentCategoryTile(CategoryModel category) {
    return ExpansionTile(
      title: Text(category.name),
      children: _buildSubCategories(category.id),
    );
  }

  List<Widget> _buildSubCategories(String parentId) {
    List<CategoryModel> subCategories = categoryController.allCategories
        .where((cat) => cat.parentId == parentId)
        .toList();
    return subCategories
        .map((subCategory) => _buildSubCategoryTile(subCategory))
        .toList();
  }

  Widget _buildSubCategoryTile(CategoryModel category) {
    return RadioListTile(
      title: Text(category.name),
      value: category.id,
      groupValue: searchController.selectedCategoryId.value,
      onChanged: (value) {
        searchController.selectedCategoryId.value = value.toString();
      },
    );
  }
}
