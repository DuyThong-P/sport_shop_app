import 'package:get/get.dart';

import '../../../data/repositories/brands/brand_repository.dart';
import '../../../data/repositories/products/product_repository.dart';
import '../../../utils/popups/loader.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load category data
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      // Fetch Brands from your data source (Firestore, API, etc.)
      final fetchedCategories = await brandRepository.getAllBrands();

      // Update the brands list
      allBrands.assignAll(fetchedCategories);

      // Update the featured brands list
      featuredBrands.assignAll(allBrands
          .where((brand) => brand.isFeatured ?? false)
          .take(4)
          .toList());
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Get All Brands
  Future<List<BrandModel>> getAllBrands() async {
    final brands = await brandRepository.getAllBrands();
    return brands;
  }

  /// -- Get Featured Brands
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    final brands = await brandRepository.getBrandsForCategory(categoryId);
    return brands;
  }

  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(String brandId, int limit) async {
    final products =
        await ProductRepository.instance.getProductsForBrand(brandId, limit);
    return products;
  }
}
