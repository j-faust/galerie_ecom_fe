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

  Future<void> updateItemQuantity(String productID, int newQuantity) async {
  if (newQuantity < 1) {
    throw Exception('Quantity must be at least 1');
  }

  final prefs = await SharedPreferences.getInstance();
  String? cartJson = prefs.getString(cartPrefsKey);

  if (cartJson == null) {
    throw Exception('Cart not found');
  }

  final Map<String, dynamic> decoded = json.decode(cartJson);
  Cart cart = Cart.fromJson(decoded);

  bool itemFound = false;
  for (var item in cart.cartItems) {
    if (item.productId == productID) {
      item.quantity = newQuantity;
      itemFound = true;
      break;
    }
  }

  if (!itemFound) {
    throw Exception('Item not found in cart');
  }

  // Recalculate total price
  double total = 0;
  for (var item in cart.cartItems) {
    total += item.productPrice * item.quantity;
  }
  cart.totalPrice = total;

  // Save updated cart
  final updatedCartJson = json.encode(cart.toJson());
  await prefs.setString(cartPrefsKey, updatedCartJson);

  // Update ValueNotifier for UI
  CartNotifier.cartCount.value = cart.cartItems.fold(0, (sum, item) => sum + item.quantity);
}

Future<void> removeItemFromCart(String productID) async {
  final prefs = await SharedPreferences.getInstance();
  String? cartJson = prefs.getString(cartPrefsKey);

  if (cartJson == null) {
    throw Exception('Cart not found');
  }

  final Map<String, dynamic> decoded = json.decode(cartJson);
  Cart cart = Cart.fromJson(decoded);

  final initialLength = cart.cartItems.length;
  cart.cartItems.removeWhere((item) => item.productId == productID);

  if (cart.cartItems.length == initialLength) {
    throw Exception('Item not found in cart');
  }

  // Recalculate total price
  double total = 0;
  for (var item in cart.cartItems) {
    total += item.productPrice * item.quantity;
  }
  cart.totalPrice = total;

  // Save updated cart
  final updatedCartJson = json.encode(cart.toJson());
  await prefs.setString(cartPrefsKey, updatedCartJson);

  // Update ValueNotifier for UI
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