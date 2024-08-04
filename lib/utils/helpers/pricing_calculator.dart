import 'package:intl/intl.dart';

import '../../features/shop/models/cart_model.dart';

class MPricingCalculator {
  /// -- Tính giá tổng dựa trên thuế và phí vận chuyển
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = 0.10; // Thuế suất 10%
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice; // Chuyển đổi sang VND
  }

  /// -- Tính phí vận chuyển
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return MPricingCalculator.toPrice(shippingCost / 1);
  }

  /// -- Tính thuế
  static String calculateTax(double productPrice, String location) {
    double taxRate = 0.10;
    double taxAmount = productPrice * taxRate * 24963;
    return MPricingCalculator.toTax(taxAmount / 1);
  }

  static double getTaxRateForLocation(String location) {
    // Tra cứu thuế suất cho vị trí đã cho từ cơ sở dữ liệu thuế suất hoặc API.
    // Trả về thuế suất phù hợp.
    return 0.10; // Ví dụ thuế suất 10%.
  }

  static double getShippingCost(String location) {
    // Tra cứu phí vận chuyển cho vị trí đã cho bằng API phí vận chuyển.
    // Tính phí vận chuyển dựa trên nhiều yếu tố như khoảng cách, trọng lượng.
    return 1; // Ví dụ phí vận chuyển 1$.
  }

  /// -- Tính tổng tất cả giá trị trong giỏ hàng và trả về tổng số tiền.
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price)
  //       .fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0) as int) * 1;
  // }
  //
  // static double convertPrice(double price, String fromCurrency, String toCurrency) {
  //   final rate = TPricingCalculator.getExchangeRate(fromCurrency, toCurrency);
  //   return price * rate;
  // }
  //
  // static double getExchangeRate(String fromCurrency, String toCurrency) {
  //   final exchangeRates = <String, double>{
  //     'USD': 1.0,
  //     'VND': 24965,
  //   };
  //   return exchangeRates[fromCurrency] ?? 0.0;
  // }

  /// -- Tính tổng tất cả giá trị trong giỏ hàng và trả về tổng số tiền.
  static double calculateCartTotal(CartModel cart) {
    if (cart.items.isEmpty) {
      return 0; // Trả về 0 nếu giỏ hàng rỗng.
    }

    // Sử dụng phương thức fold để tính tổng giá trị của tất cả các mặt hàng trong giỏ hàng.
    double total = cart.items
        .map((e) =>
            e.price ??
            0) // Chuyển đổi giá thành số, nếu giá là null thì trả về 0.
        .fold(0, (previousPrice, currentPrice) => previousPrice + currentPrice);

    return total;
  }

  /// Tính Format tiền Việt
  static final NumberFormat _appNumberFormat = NumberFormat();
  static final DateFormat AppDateFormat = DateFormat('yyyy-MM-dd');
  static String toPrice(double price) {
    double priceVND = price * 24963;
    return "${_appNumberFormat.format(priceVND.round())} đ";
    // return _appNumberFormat.format(priceVND.round()) + " đ";
  }

  static String toTax(double tax) {
    double taxVND = tax;
    return "${_appNumberFormat.format(taxVND.round())} đ";
    // return _appNumberFormat.format(priceVND.round()) + " đ";
  }
}
