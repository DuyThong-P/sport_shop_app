//import 'dart:convert';
import 'package:get/get.dart';
//import 'package:http/http.dart' as http;

import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../utils/popups/loader.dart';
import '../../models/banner_model.dart';

class BannerController extends GetxController {
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanner();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  //* Fetch banners
  Future<void> fetchBanner() async {
    try {
      //* Show loader while loading categories
      isLoading.value = true;

      //* Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //* Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      MLoaders.warningSnackBar(title: 'Ôi Không!', message: e.toString());
    } finally {
      //* Remove Loader
      isLoading.value = false;
    }
  }

  // Future<void> fetchBanners() async {
  //   try {
  //     // Bắt đầu hiển thị loading
  //     bannersLoading.value = true;

  //     // Gửi yêu cầu HTTP để lấy danh sách các banner từ API
  //     final response = await http.get(
  //         Uri.parse('http://apiapp-production-f103.up.railway.app/banners'));

  //     // Kiểm tra xem yêu cầu có thành công không
  //     if (response.statusCode == 200) {
  //       // Chuyển đổi dữ liệu JSON thành danh sách các đối tượng BannerModel
  //       List<dynamic> responseData = jsonDecode(response.body);
  //       List<BannerModel> bannerModels =
  //           responseData.map((json) => BannerModel.fromJson(json)).toList();

  //       // Cập nhật danh sách banners
  //       banners.assignAll(bannerModels);
  //     } else {
  //       // Nếu yêu cầu không thành công, ném một ngoại lệ với thông báo lỗi
  //       throw Exception('Failed to load banners: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Xử lý ngoại lệ: Hiển thị thông báo lỗi
  //     MLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   } finally {
  //     // Kết thúc hiển thị loading sau khi hoàn thành hoặc gặp lỗi
  //     bannersLoading.value = false;
  //   }
  // }
}
