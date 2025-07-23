import 'product.dart';

class OrderItem {
  final String orderItemId;
  final Product product;
  final int quantity;
  final double discount;
  final double orderedProductPrice;

  OrderItem({
    required this.orderItemId,
    required this.product,
    required this.quantity,
    required this.discount,
    required this.orderedProductPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderItemId: json['orderItemId'].toString(),
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      discount: (json['discount'] as num).toDouble(),
      orderedProductPrice: (json['orderedProductPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderedItemId': orderItemId,
      'product':product.toJson(),
      'quantity': quantity,
      'discount': discount,
      'orderedProductPrice':orderedProductPrice,
    };
  }
}