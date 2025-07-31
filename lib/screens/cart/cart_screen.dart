import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/cart_item.dart';
import 'package:galerie_ecom_fe/providers/cart_provider.dart';
import 'package:provider/provider.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cart?.cartItems ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cartItems.isEmpty
        ? const Center(child: Text('Your cart is empty'),)
        : ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (ctx, i) {
            CartItem item = cartItems[i];
            return ListTile(
              leading: Image.network(item.product.productImage, width: 50, height: 50),
              title: Text(item.product.productName),
              subtitle: Text("Qty: ${item.quantity}"),
              trailing: Text("\$${(item.productPrice * item.quantity).toStringAsFixed(2)}"),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {

            },
            child: const Text("Proceed to Checkout"),
          ),
        ),
    );
  }
}