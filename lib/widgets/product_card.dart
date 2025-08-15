import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.productImage,
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 40),
        ),
        title: Text(product.productName),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
