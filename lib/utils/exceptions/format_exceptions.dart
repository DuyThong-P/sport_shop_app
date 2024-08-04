/// Custom exception class to handle various format-related errors.
class MFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const MFormatException(
      [this.message =
          'Đã xảy ra lỗi định dạng không mong muốn. Vui lòng kiểm tra đầu vào của bạn.']);

  /// Create a format exception from a specific error message.
  factory MFormatException.fromMessage(String message) {
    return MFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory MFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const MFormatException(
            'Định dạng địa chỉ email không hợp lệ. Vui lòng nhập email hợp lệ.');
      case 'invalid-phone-number-format':
        return const MFormatException(
            'Định dạng số điện thoại được cung cấp không hợp lệ. Vui lòng nhập một số hợp lệ.');
      case 'invalid-date-format':
        return const MFormatException(
            'Định dạng ngày không hợp lệ. Vui lòng nhập một ngày hợp lệ.');
      case 'invalid-url-format':
        return const MFormatException(
            'Định dạng URL không hợp lệ. Vui lòng nhập một URL hợp lệ.');
      case 'invalid-credit-card-format':
        return const MFormatException(
            'Định dạng thẻ tín dụng không hợp lệ. Vui lòng nhập số thẻ tín dụng hợp lệ.');
      case 'invalid-numeric-format':
        return const MFormatException('Đầu vào phải có định dạng số hợp lệ.');
      // Add more cases as needed...
      default:
        return const MFormatException();
    }
  }
}
