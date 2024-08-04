///  Lớp ngoại lệ để xử lý các lỗi khác nhau.
class MExceptions implements Exception {
  /// Thông điệp lỗi đi kèm.
  final String message;

  /// Constructor mặc định với thông điệp lỗi chung chung.
  const MExceptions(
      [this.message = 'Đã xảy ra một lỗi không mong muốn. Vui lòng thử lại.']);

  /// Tạo một ngoại lệ xác thực từ một mã lỗi xác thực Firebase.
  factory MExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const MExceptions(
            'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.');
      case 'invalid-email':
        return const MExceptions(
            'Địa chỉ email không hợp lệ. Vui lòng nhập email hợp lệ.');
      case 'weak-password':
        return const MExceptions(
            'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.');
      case 'user-disabled':
        return const MExceptions(
            'Tài khoản người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được giúp đỡ.');
      case 'user-not-found':
        return const MExceptions(
            'Thông tin đăng nhập không hợp lệ. Không tìm thấy người dùng.');
      case 'wrong-password':
        return const MExceptions(
            'Mật khẩu không chính xác. Vui lòng kiểm tra lại mật khẩu và thử lại.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const MExceptions(
            'Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại thông tin của bạn.');
      case 'too-many-requests':
        return const MExceptions('Quá nhiều yêu cầu. Vui lòng thử lại sau.');
      case 'invalid-argument':
        return const MExceptions(
            'Đối số không hợp lệ được cung cấp cho phương thức xác thực.');
      case 'invalid-password':
        return const MExceptions('Mật khẩu không chính xác. Vui lòng thử lại.');
      case 'invalid-phone-number':
        return const MExceptions('Số điện thoại đã cung cấp không hợp lệ.');
      case 'operation-not-allowed':
        return const MExceptions(
            'Nhà cung cấp đăng nhập bị vô hiệu hóa cho dự án Firebase của bạn.');
      case 'session-cookie-expired':
        return const MExceptions(
            'Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại');
      case 'uid-already-exists':
        return const MExceptions(
            'ID người dùng đã được sử dụng bởi người dùng khác.');
      case 'sign_in_failed':
        return const MExceptions('Đăng nhập thất bại. Vui lòng thử lại.');
      case 'network-request-failed':
        return const MExceptions(
            'Yêu cầu mạng không thành công. Vui lòng kiểm tra kết nối internet của bạn.');
      case 'internal-error':
        return const MExceptions('Lỗi nội bộ. Vui lòng thử lại sau.');
      case 'invalid-verification-code':
        return const MExceptions(
            'Mã xác minh không hợp lệ. Vui lòng nhập mã hợp lệ.');
      case 'invalid-verification-id':
        return const MExceptions(
            'ID xác minh không hợp lệ. Vui lòng yêu cầu mã xác minh mới.');
      case 'quota-exceeded':
        return const MExceptions(
            'Đã vượt quá hạn ngạch. Vui lòng thử lại sau.');
      default:
        return const MExceptions();
    }
  }
}
