import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../popups/loader.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //* Lấy instance của NetworkManager khởi tạo trình quản lý mạng và thiết lập luồng để kiểm tra trạng thái kết nối liên tục.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  //* Cập nhật trạng thái kết nối dựa trên các thay đổi về kết nối và hiển thị một popup cảnh báo nếu không có kết nối internet.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      MLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  //* Kiểm tra trạng thái kết nối internet.
  //* Trả về true nếu được kết nối, false nếu không.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  //* Dừng hoặc đóng luồng kết nối đang hoạt động.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
