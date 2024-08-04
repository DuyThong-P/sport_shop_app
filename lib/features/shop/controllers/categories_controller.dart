import 'package:get/get.dart';

import '../../../data/repositories/categories/category_repository.dart';
import '../../../data/repositories/products/product_repository.dart';
import '../../../utils/popups/loader.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //* Load category data
  Future<void> fetchCategories() async {
    try {
      //* Show loader while loading categories
      isLoading.value = true;

      //* Fetch categories from data source (Firestore, API,...)
      final categories = await _categoryRepository.getAllCategories();

      //* Update the categories list
      allCategories.assignAll(categories);

      //* Fillter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      MLoaders.warningSnackBar(title: 'Ôi Không!', message: e.toString());
    } finally {
      //* Remove Loader
      isLoading.value = false;
    }
  }

  //* Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ôi Không!', message: e.toString());
      return [];
    }
  }

  //* Get Category or Sub-Category products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      //* Fetch limited (4) products against each subCategory;
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      MLoaders.warningSnackBar(title: 'Ôi Không!', message: e.toString());
      return [];
    }
  }
}










// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../data/repositories/products/product_repository.dart';
// import '../models/category_model.dart';
// import '../models/product_model.dart';

// class CategoryController extends GetxController {
//   static CategoryController get instance => Get.find();
//   final url =
//       Uri.parse('http://apiapp-production-f103.up.railway.app/categories');

//   var isLoading = false.obs;
//   var allCategories = <CategoryModel>[].obs;
//   var featuredCategories = <CategoryModel>[].obs;
//   var subCategories = <CategoryModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }

//   void fetchCategories() async {
//     isLoading(true);
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
//         allCategories.value = jsonResponse
//             .map((data) => CategoryModel.fromJson(data as Map<String, dynamic>))
//             .toList();
//         featuredCategories
//             .assignAll(allCategories.where((item) => item.isFeatured));
//       } else {
//         throw Exception('Failed to load categories: ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch data: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<List<CategoryModel>> getSubCategories(String categoryId) async {
//     try {
//       return allCategories
//           .where((category) => category.parentId == categoryId)
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch sub-categories: $e',
//           snackPosition: SnackPosition.BOTTOM);
//       return [];
//     }
//   }

//   Future<List<ProductModel>> getCategoryProducts(
//       {required String categoryId, int limit = 4}) async {
//     try {
//       final products = await ProductRepository.instance
//           .getProductsForCategory(categoryId: categoryId, limit: limit);
//       return products;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch products: $e',
//           snackPosition: SnackPosition.BOTTOM);
//       return [];
//     }
//   }
// }
