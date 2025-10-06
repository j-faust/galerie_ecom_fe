import 'dart:convert';

import 'package:galerie_ecom_fe/models/cart.dart';
import 'package:galerie_ecom_fe/models/user.dart';
import 'package:galerie_ecom_fe/services/api_service.dart';
import 'package:galerie_ecom_fe/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class CartNotifier {
  // This holds the number of items in the cart
  static ValueNotifier<int> cartCount = ValueNotifier<int>(0);
}

class CartService {
  final ApiService _apiService = ApiService();
  
  static const String cartPrefsKey = 'user_cart';

 Future<Cart?> loadCart() async {
  final prefs = await SharedPreferences.getInstance();
  String? cartJson = prefs.getString(cartPrefsKey);
  if (cartJson == null) {
    Cart? cart;
    createInitialCart().then((c) {
      saveCart(c);
      CartNotifier.cartCount.value = c.cartItems.fold(0, (sum, item) => sum + item.quantity); // update notifier
      return c;
    });
  } else {
    final Map<String, dynamic> decoded = json.decode(cartJson);
    final cart = Cart.fromJson(decoded);
    CartNotifier.cartCount.value = cart.cartItems.fold(0, (sum, item) => sum + item.quantity); // update notifier
    return cart;
  }
  return null;
}

  Future<void> saveCart(Cart cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(cart.toJson());
    await prefs.setString(cartPrefsKey, cartJson);
    CartNotifier.cartCount.value = cart.cartItems.fold(0, (sum, item) => sum + item.quantity);
 }

  Future<Cart> createInitialCart() async {
  final AuthService authService = AuthService();

  User? user = await authService.getCurrentUser();

  if (user == null) {
    throw Exception('User not authenticated. Cannot create cart.');
  }

    final String cartId = const Uuid().v4();
    return Cart(
      cartId: cartId,
      user: user,
      cartItems: [],
      totalPrice: 0.0,
    );
  }
}