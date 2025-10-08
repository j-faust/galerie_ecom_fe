import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/cart.dart';
import 'package:galerie_ecom_fe/services/cart_service.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import 'stripe_checkout_page.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart? cart;
  bool isLoading = true;
  bool updating = false;

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

  void recalculateTotal() {
    if (cart == null) return;
    double total = 0.0;
    for (var item in cart!.cartItems) {
      total += item.productPrice * item.quantity;
    }
    cart!.totalPrice = total;
  }

  Future<void> updateQuantity(int index, int newQty) async {
    final item = cart!.cartItems[index];
    if (newQty < 1) return;

    setState(() {
      updating = true;
      item.quantity = newQty;
      recalculateTotal(); // instant total update
    });

    try {
      await _cartService.updateItemQuantity(item.productId, newQty);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating quantity: $e')),
      );
      await loadCart(); // rollback
    } finally {
      setState(() => updating = false);
    }
  }

  Future<void> confirmRemoveItem(int index) async {
    final item = cart!.cartItems[index];

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove item?'),
        content: Text('Are you sure you want to remove "${item.productName}" from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await removeItem(index);
    }
  }

  Future<void> removeItem(int index) async {
    final item = cart!.cartItems[index];

    setState(() {
      updating = true;
      cart!.cartItems.removeAt(index);
      recalculateTotal(); // instant update
    });

    try {
      await _cartService.removeItemFromCart(item.productId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing item: $e')),
      );
      await loadCart(); // rollback
    } finally {
      setState(() => updating = false);
    }
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
      body: Stack(
        children: [
          Padding(
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
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.productName),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: updating || item.quantity <= 1
                                  ? null
                                  : () => updateQuantity(index, item.quantity - 1),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: updating
                                  ? null
                                  : () => updateQuantity(index, item.quantity + 1),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '\$${(item.productPrice * item.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: updating ? null : () => confirmRemoveItem(index),
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
                    onPressed: updating
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    StripeCheckoutPage(amount: cart!.totalPrice),
                              ),
                            );
                          },
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),

          if (updating)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
