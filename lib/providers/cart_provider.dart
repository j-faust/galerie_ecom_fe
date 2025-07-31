import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/services/cart_service.dart';
import 'package:galerie_ecom_fe/models/cart.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();

  Cart? _cart;
  bool _isLoading = false;
  String? _token;

  Cart? get cart => _cart;

  void setToken(String token) {
    _token = token;
  }

  Future<void> fetchCart() async {
    if(_token == null) return;
    _isLoading = true;
    notifyListeners();

    try {
      _cart = await _cartService.getCart(_token!);
    } catch (e) {
      print('Fetch Cart Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(String productId, int quantity) async {
    if (_token == null) return;
      await _cartService.addToCart(productId, quantity, _token!);
      await fetchCart();
  }

  Future<void> updateQuantity(String productId, String operation) async {
    if(_token == null) return;
    await _cartService.updateQuantity(productId, operation, _token!);
    await fetchCart();
  }

  Future<void> removeFromCart(String cartId, String productId) async {
    if(_token == null) return;
    await _cartService.removeFromCart(cartId, productId, _token!);
    await fetchCart();
  }
}