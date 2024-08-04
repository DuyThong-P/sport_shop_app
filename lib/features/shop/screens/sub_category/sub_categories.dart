import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/products/product_card/product_card_horizontal.dart';
import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../../../utils/contants/image_strings.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/categories_controller.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../all_products/all_products.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({Key? key, required this.category})
      : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    // final CategoryController controller =
    //     Get.put(CategoryController()); // Ensure the controller is initialized

    // // Asynchronously load sub-categories right after obtaining the controller instance
    // Future<List<CategoryModel>> subCategories =
    //     controller.getSubCategories(category.id);

    return Scaffold(
      appBar: MAppBar(showBackArrow: true, title: Text(category.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const MRoundedImage(
                  width: double.infinity,
                  imageUrl: MImages.promoBanner3,
                  applyImageRadius: true),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = MHorizontalProductShimmer();
                    final widget = MCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record found.
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final childCategory = subCategories[index];
                        return FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: childCategory.id),
                            builder: (context, snapshot) {
                              /// Handle Loader, No Record, OR Error Message
                              final widget =
                                  MCloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;

                              /// Record found
                              final products = snapshot.data!;

                              return Column(
                                children: [
                                  /// Sub Category Heading
                                  MSectionHeading(
                                    title: childCategory.name,
                                    showActionButton: true,
                                    onPressed: () => Get.to(() => AllProducts(
                                        title: childCategory.name,
                                        futureMethod:
                                            controller.getCategoryProducts(
                                                categoryId: childCategory.id,
                                                limit: -1))),
                                  ),
                                  const SizedBox(
                                      height: MSizes.spaceBtwItems / 2),

                                  /// Sub Category Products
                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              width: MSizes.spaceBtwItems),
                                      itemBuilder: (context, index) =>
                                          MProductCardHorizontal(
                                        product: products[index],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  })

              // FutureBuilder<List<CategoryModel>>(
              //   future: controller.getSubCategories(category.id),
              //   builder: (context, snapshot) {
              //     if (category.name.isEmpty) {
              //       return const Center(
              //           child: Text(
              //               'No sub-categories available!')); // Handle empty data case
              //     } else {
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         //itemCount: category.children?.length ?? 0,
              //         physics: const NeverScrollableScrollPhysics(),

              //         itemBuilder: (context, index) {
              //           final childCategory = category.children![index];
              //           return Column(
              //             children: [
              //               /// Sub Category Heading
              //               MSectionHeading(
              //                 title: childCategory.name,
              //                 showActionButton: true,
              //                 onPressed: () => Get.to(() => AllProducts(
              //                       title: childCategory.name,
              //                       future: ProductRepository.instance
              //                           .getProductsForCategory(
              //                               categoryId: childCategory.id,
              //                               limit: -1),
              //                     )),
              //               ),
              //               const SizedBox(height: MSizes.spaceBtwItems / 2),

              //               /// Sub Category Products
              //               // SizedBox(
              //               //   height: 120,
              //               //   child: ListView.separated(
              //               //     scrollDirection: Axis.horizontal,
              //               //     itemCount: products.length,
              //               //     separatorBuilder: (context, index) => const SizedBox(width: MSizes.spaceBtwItems),
              //               //     itemBuilder: (context, index) => MProductCardHorizontal(product: products[index]),
              //               //   ),
              //               // ),
              //               const SizedBox(height: MSizes.spaceBtwSections),
              //             ],
              //           );
              //         },
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubCategoryItem(
      BuildContext context, CategoryModel subCategory) {
    final controller = CategoryController.instance;
    return FutureBuilder<List<ProductModel>>(
      future: controller.getCategoryProducts(categoryId: subCategory.id),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MHorizontalProductShimmer();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return Center(
              child: Text('No products found for ${subCategory.name}'));
        } else {
          final products = snapshot.data!;
          return Column(
            children: [
              MSectionHeading(
                title: subCategory.name,
                showActionButton: true,
                onPressed: () => Get.to(() => AllProducts(
                      title: subCategory.name,
                      futureMethod: ProductRepository.instance
                          .getProductsForCategory(
                              categoryId: subCategory.id, limit: -1),
                    )),
              ),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              _buildProductList(context, products),
              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          );
        }
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductModel> products) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: MSizes.spaceBtwItems),
        itemBuilder: (context, index) =>
            MProductCardHorizontal(product: products[index]),
      ),
    );
  }
}
