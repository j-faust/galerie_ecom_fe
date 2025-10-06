
import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/product.dart';
import 'package:galerie_ecom_fe/services/cart_service.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import 'package:galerie_ecom_fe/models/cart.dart';
import 'package:galerie_ecom_fe/models/cart_item.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Cart? cart;
  bool isLoading = true;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final fetchedCart = await _cartService.loadCart();
    setState(() {
      cart = fetchedCart;
      isLoading = false;
    });
  }

  void _addToCart() {
    if (cart == null) _loadCart();
  
      Cart workingCart = cart!;
  

    final existingItemIndex = workingCart.cartItems.indexWhere(
      (item) => item.productId == widget.product.productId
    );

    if (existingItemIndex != -1) {
      // Product already in cart – increase quantity
      final existingItem = workingCart.cartItems[existingItemIndex];
      final updatedItem = CartItem(
        cartItemId: existingItem.cartItemId,
        productId: existingItem.productId,
        productName: existingItem.productName,
        quantity: existingItem.quantity + 1,
        discount: existingItem.discount,
        productPrice: existingItem.productPrice,
      );
      workingCart.cartItems[existingItemIndex] = updatedItem;
    } else {
      // Add new item to cart
      final newItem = CartItem(
        cartItemId: UniqueKey().toString(),
        productId: widget.product.productId,
        productName: widget.product.productName,
        quantity: 1,
        discount: 0.0,
        productPrice: widget.product.price,
      );
      workingCart.cartItems.add(newItem);
      CartNotifier.cartCount.value = workingCart.cartItems.fold(0, (sum, item) => sum + item.quantity);; 
    }

    // Update total price
    workingCart.totalPrice = workingCart.cartItems.fold(
      0.0,
      (sum, item) => sum + (item.productPrice - item.discount) * item.quantity,
    );

    // Optional: persist cart update
    _cartService.saveCart(workingCart).then((c) {
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.productName} added to cart')),
    );

    setState(() {}); // Update UI if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpatterAppBar(
        title: widget.product.productName,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          widget.product.productImage,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.product.productName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, color: Colors.green[700]),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'This is a great product that you might want to add to your collection. You can add more description or features here.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Buy', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
