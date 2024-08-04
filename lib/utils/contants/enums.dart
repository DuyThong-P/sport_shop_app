//  Phân biệt các loại sản phẩm
enum ProductType { single, variable }

//  Chỉ định các kích thước văn bản
enum TextSizes { small, medium, large }

//  Theo dõi trạng thái của một đơn hàng
enum OrderStatus { pending, processing, shipped, delivered, cancelled }

// Liệt kê các phương thức thanh toán được hỗ trợ trong ứng dụng.
enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razor,
  paytm
}
