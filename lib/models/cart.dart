import 'cart_item.dart';
import 'user.dart';

class Cart{
  final String cartId;
  final User user;
  final List<CartItem> cartItems;
  final double totalPrice;

  Cart({
    required this.cartId,
    required this.user,
    required this.cartItems,
    required this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cartId'].toString(),
      user: User.fromJson(json['user']),
      cartItems: (json['cartItems'] as List)
        .map((item) => CartItem.fromJson(item))
        .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'user': user.toJson(),
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }
}