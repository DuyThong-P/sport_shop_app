/// LỚP XÁC THỰC - (VALIDATION CLASS)
class MValidator {
  /// Xác thực văn bản - (Empty Text Validation)
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName là bắt buộc.';
    }

    return null;
  }

  /// Username Validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Tên người dùng là bắt buộc.';
    }

    // Định nghĩa một mẫu biểu thức chính quy (regular expression) cho tên người dùng.
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    // Tạo một đối tượng RegExp từ mẫu đã định nghĩa.
    final regex = RegExp(pattern);

    // Sử dụng phương thức hasMatch để kiểm tra xem tên người dùng có khớp với mẫu hay không.
    bool isValid = regex.hasMatch(username);

    // Kiểm tra xem tên người dùng có bắt đầu hoặc kết thúc bằng dấu gạch dưới (_) hoặc dấu gạch ngang (-) hay không.
    if (isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'Tên người dùng không hợp lệ.';
    }

    return null;
  }

  /// Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email là bắt buộc.';
    }

    // Regular expression for email validation (Biểu thức chính quy xác thực email)
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Địa chỉ email không hợp lệ.';
    }

    return null;
  }

  /// Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu là bắt buộc.';
    }

    // Check độ dài tối thiểu của mật khẩu
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }

    // Check chữ viết hoa
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải chứa ít nhất một chữ cái viết hoa.';
    }

    // Check số điện thoại
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải chứa ít nhất một số.';
    }

    // Check các ký tự đặt biệt
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
    }

    return null;
  }

  // Xác thực số điện thoại (Phone Number Validation)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại là bắt buộc.';
    }

    // Biểu thức chính quy để xác thực số điện thoại
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ (yêu cầu 10 chữ số).';
    }

    return null;
  }

  // Thêm các trình xác thực tùy chỉnh khác nếu cần.
}
