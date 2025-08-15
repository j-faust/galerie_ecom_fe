import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/cart.dart';
import 'package:galerie_ecom_fe/services/cart_service.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart? cart;
  bool isLoading = true;

  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final fetchedCart = await _cartService.loadCart();
    setState(() {
      cart = fetchedCart;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        appBar: SpatterAppBar(title: 'Galerie Cart'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (cart == null || cart!.cartItems.isEmpty) {
      return const Scaffold(
        appBar: SpatterAppBar(title: 'Galerie Cart'),
        body: Center(child: Text('Cart is empty.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User: ${cart!.user.username}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: cart!.cartItems.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = cart!.cartItems[index];
                  
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Text('Qty: ${item.quantity}'),
                    trailing: Text(
                      '\$${(item.productPrice * item.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$${cart!.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle checkout
                },
                child: const Text('Proceed to Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}