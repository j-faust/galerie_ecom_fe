import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/product.dart';
import 'package:galerie_ecom_fe/services/api_service.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _addToCart() async {
      final response = await ApiService().post("/cart/add", {
        'productId': product.productId,
        'quantity': 1,
      });

      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.productName} added to cart!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add to cart!')),
        );
      }
    }

    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.network(product.productImage),
          Text(
            product.productName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("\$${product.price.toStringAsFixed(2)}"),
          ElevatedButton(onPressed: _addToCart, child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}