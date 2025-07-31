import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:galerie_ecom_fe/models/cart.dart';
import 'package:galerie_ecom_fe/config.dart';


class CartService {
  final String baseUrl = "$API_BASE_URL/api/carts";

  Future<void> addToCart(String productId, int quantity, String token) async {
    final url = Uri.parse('$baseUrl/products/$productId/quantity/$quantity');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to Add to Cart: ${response.body}' );
    }
  }

  Future<Cart> getCart(String token) async {
    final url = Uri.parse('$baseUrl/users/cart');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if(response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch cart: ${response.body}');
    }
  }

  Future<void> updateQuantity(String productId, String operation, String token) async {
     final url = Uri.parse('$baseUrl/product/$productId/quantity/$operation');
     final response = await http.put(
      url,
      headers: {'Authorization': 'Bearer $token'}
     ); 

     if(response.statusCode != 200) {
      throw Exception('Failed to updated cart quantity: ${response.body}');
     }
    }

  Future<void> removeFromCart(String cartId, String productId, String token) async {
    final url = Uri.parse('$baseUrl/$cartId/product/$productId');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'}
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to remove item: ${response.body}');
    }
  }


}