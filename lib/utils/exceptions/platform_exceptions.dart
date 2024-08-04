/// Exception class for handling various platform-related errors.
class MPlatformException implements Exception {
  final String code;

  MPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại thông tin của bạn.';
      case 'too-many-requests':
        return 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
      case 'invalid-argument':
        return 'Đối số được cung cấp cho phương thức xác thực không hợp lệ.';
      case 'invalid-password':
        return 'Mật khẩu không đúng. Vui lòng thử lại.';
      case 'invalid-phone-number':
        return 'Số điện thoại được cung cấp không hợp lệ.';
      case 'operation-not-allowed':
        return 'Nhà cung cấp đăng nhập bị vô hiệu hóa đối với dự án Firebase của bạn.';
      case 'session-cookie-expired':
        return 'Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng được cung cấp đã được người dùng khác sử dụng.';
      case 'sign_in_failed':
        return 'Đăng nhập không thành công. Vui lòng thử lại.';
      case 'network-request-failed':
        return 'Yêu cầu mạng không thành công. Xin vui lòng kiểm tra kết nối Internet của bạn.';
      case 'internal-error':
        return 'Lỗi bên trong. Vui lòng thử lại sau.';
      case 'invalid-verification-code':
        return 'Mã xác minh không hợp lệ. Vui lòng nhập mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác minh không hợp lệ. Vui lòng yêu cầu mã xác minh mới.';
      case 'quota-exceeded':
        return 'Đã vượt quá hạn ngạch. Vui lòng thử lại sau.';
      // Add more cases as needed...
      default:
        return 'Đã xảy ra lỗi nền tảng không mong muốn. Vui lòng thử lại.';
    }
  }
}
