import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../data/repositories/banners/banner_repository.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../data/repositories/categories/category_repository.dart';
import '../../../data/repositories/products/product_repository.dart';
import '../../../utils/contants/image_strings.dart';
import '../../../utils/popups/fullscreen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../../shop/controllers/brand_controller.dart';
import '../../shop/controllers/categories_controller.dart';
import '../../shop/controllers/dummy_data.dart';
import '../../shop/controllers/product/banner_controller.dart';
import '../../shop/controllers/product/product_controller.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find();

  Future<void> uploadCategories() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
          'Sit Tight! Your CATEGORIES are uploading...',
          MImages.cloudUploadingAnimation);

      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(MDummyData.categories);

      // Re-fetch latest Categories
      await CategoryController.instance.fetchCategories();

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadProductCategories() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your PRODUCT CATEGORIES relationship is uploading...',
        MImages.cloudUploadingAnimation,
      );

      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller
          .uploadProductCategoryDummyData(MDummyData.productCategories);

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBrands() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
          'Sit Tight! Your BRANDS are uploading...',
          MImages.cloudUploadingAnimation);

      final controller = Get.put(BrandRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(MDummyData.brands);

      // Re-fetch latest Brands
      final brandController = Get.put(BrandController());
      await brandController.getFeaturedBrands();

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Brands Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBrandCategory() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your BRANDS & CATEGORIES relationship is uploading...',
        MImages.cloudUploadingAnimation,
      );

      final controller = Get.put(BrandRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadBrandCategoryDummyData(MDummyData.brandCategory);

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Brands Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadProducts() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your Products are uploading. It may take a while...',
        MImages.cloudUploadingAnimation,
      );

      final controller = Get.put(ProductRepository());

      // Upload All Products and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(MDummyData.products);

      // Re-fetch latest Featured Products
      ProductController.instance.fetchFeaturedProducts();

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Products Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBanners() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      MFullScreenLoader.openLoadingDialog(
          'Sit Tight! Your Banners are uploading. It may take a while...',
          MImages.cloudUploadingAnimation);

      final controller = Get.put(BannerRepository());

      // Upload All Products and replace the Parent IDs in Firebase Console
      await controller.uploadBannersDummyData(MDummyData.banners);

      // Re-fetch latest Banners
      final bannerController = Get.put(BannerController());
      await bannerController.fetchBanner();

      MLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'All Products Uploaded Successfully.');
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      MFullScreenLoader.stopLoading();
    }
  }
}
