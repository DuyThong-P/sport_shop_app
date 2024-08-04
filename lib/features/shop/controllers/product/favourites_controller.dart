import 'dart:convert';

import 'package:get/get.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loader.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize by fetching the list of already added favorites
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = MLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Method to check if a product is selected (favorite)
  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Add Product to Favourites
  Future<void> toggleFavoriteProduct(String productId) async {
    // If favorites do not have this product, Add. Else Toggle
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      MLoaders.customToast(message: 'Sản phẩm đã được thêm vào yêu thích.');
    } else {
      MLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      MLoaders.customToast(
          message: 'Sản phẩm đã bị xóa khỏi danh sách yêu thích');
    }
  }

  // Save the updated favorites to storage
  Future<void> saveFavoritesToStorage() async {
    final encodedFavorites = json.encode(favorites);
    MLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  /// Method to get the list of favorite products
  Future<List<ProductModel>> favoriteProducts() {
    return ProductRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
