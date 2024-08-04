/// Custom exception class to handle various Firebase authentication-related errors.
class MFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Hàm khởi tạo nhận mã lỗi.
  MFirebaseAuthException(this.code);

  /// Lấy thông điệp lỗi tương ứng dựa trên mã lỗi.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ. Vui lòng nhập email hợp lệ.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.';
      case 'user-disabled':
        return 'Tài khoản người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được giúp đỡ.';
      case 'user-not-found':
        return 'Thông tin đăng nhập không hợp lệ. Không tìm thấy người dùng';
      case 'wrong-password':
        return 'Mật khẩu không chính xác. Vui lòng kiểm tra lại mật khẩu và thử lại.';
      case 'invalid-verification-code':
        return 'Mã xác minh không hợp lệ. Vui lòng nhập mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác minh không hợp lệ. Vui lòng yêu cầu mã xác minh mới.';
      case 'quota-exceeded':
        return 'Xin lỗi, chúng tôi hiện không thể xử lý yêu cầu của bạn. Vui lòng thử lại sau. ';
      case 'email-already-exists':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với một nhà cung cấp khác.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'Thông tin xác thực này đã được liên kết với một tài khoản người dùng khác.';
      case 'user-mismatch':
        return 'Thông tin xác thực được cung cấp không khớp với người dùng đã đăng nhập trước đó';
      case 'account-exists-with-different-credential':
        return 'Đã tồn tại một tài khoản với cùng địa chỉ email nhưng thông tin đăng nhập khác.';
      case 'operation-not-allowed':
        return 'Thao tác này không được phép. Vui lòng liên hệ hỗ trợ để được trợ giúp.';
      case 'expired-action-code':
        return 'Mã xác thực đã hết hạn. Vui lòng yêu cầu mã xác thực mới.';
      case 'invalid-action-code':
        return 'Mã hành động không hợp lệ. Vui lòng kiểm tra mã và thử lại.';
      case 'missing-action-code':
        return 'Thiếu mã hành động. Vui lòng cung cấp mã hành động hợp lệ.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      case 'user-not-found':
        return 'Không tìm thấy người dùng với email hoặc UID đã cho.';
      case 'invalid-credential':
        return 'Thông tin xác thực được cung cấp bị sai định dạng hoặc đã hết hạn.';
      case 'wrong-password':
        return 'Mật khẩu không hợp lệ. Vui lòng kiểm tra mật khẩu của bạn và thử lại.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing the iframe src attribute.';
      case 'auth-domain-config-required':
        return 'The authDomain configuration is required for the action code verification link.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credential.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'invalid-cordova-configuration':
        return 'The provided Cordova configuration is invalid.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';
      case 'invalid-credential':
        return 'The supplied credential is invalid. Please check the credential and try again.';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API key.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}
