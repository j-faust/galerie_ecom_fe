
import 'product.dart';

class CartItem {
  final String cartItemId;
  final Product product;
  final int quantity;
  final double discount;
  final double productPrice;

  CartItem({
    required this.cartItemId,
    required this.product,
    required this.quantity,
    required this.discount,
    required this.productPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cartItemId'].toString(),
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      discount: (json['discount'] as num).toDouble(),
      productPrice: (json['productPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'product': product.toJson(),
      'quantity': quantity,
      'discount': discount,
      'productPrice': productPrice,
    };
  }

}