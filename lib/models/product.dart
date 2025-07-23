
class Product {
  final String productId;
  final String productName;
  final String productImage;
  final int productQuantity;
  final String productDescription;
  final double price;
  final double discount;
  final double specialPrice;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productQuantity,
    required this.productDescription,
    required this.price,
    required this.discount, 
    required this.specialPrice
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'].toString(),
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      productQuantity: json['productQuantity'] ?? 0,
      productDescription: json['productDescription'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      specialPrice: (json['specialPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productimage': productImage,
      'productQuantity': productQuantity,
      'productDescription': productDescription,
      'price': price,
      'discount': discount,
      'specialPrice': specialPrice,
    };
  }
}