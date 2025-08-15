

class CartItem {
  final String cartItemId;
  //final Product product;
  final String productId;
  final String productName;
  final int quantity;
  final double discount;
  final double productPrice;

  CartItem({
    required this.cartItemId,
    //required this.product,
    required this.productId,
    required this.productName,                                                                                                                              
    required this.quantity,
    required this.discount,
    required this.productPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cartItemId'].toString(),
      //product: Product.fromJson(json['product']),
      productId: json['productId'].toString(),
      productName: json['productName'].toString(),
      quantity: json['quantity'],
      discount: (json['discount'] as num).toDouble(),
      productPrice: (json['productPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      //'product': product,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'discount': discount,
      'productPrice': productPrice,
    };
  }
}