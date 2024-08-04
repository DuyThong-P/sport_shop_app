import 'package:get_storage/get_storage.dart';

class MLocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static MLocalStorage? _instance;

  MLocalStorage._internal();

  /// Create a named constructor to obtain an instance with a specific bucket name
  factory MLocalStorage.instance() {
    _instance ??= MLocalStorage._internal();
    return _instance!;
  }

  /// Phương thức khởi tạo không đồng bộ (Asynchronous initialization method)
  static Future<void> init(String bucketName) async {
    // Very Important when you want to use Bucket's
    await GetStorage.init(bucketName);
    _instance = MLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  /// Phương thức chung để lưu dữ liệu (Generic method to save data)
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Đọc dữ liệu (Generic method to read data)
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Xóa dữ liệu (Generic method to remove data)
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Xóa toàn bộ dữ liệu (Clear all data in storage)
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
