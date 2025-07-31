import 'dart:html';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/order.dart'; 

class OrderService{
  static Future<Order> submitOrder({
    required String jwtToken,
    required String paymentMethod,
    required int addressId,
    required String pgName,
    required String pgPaymentId,
    required String pgStatus,
    required String pgResponseMessage,

  }) async {
    final uri = Uri.parse(
      'http://localhost:8080/api/order/users/payments/$paymentMethod',
    );

    final body = {
      "addressId": addressId,
      "pgName": pgName,
      "pgPaymentId": pgPaymentId,
      "pgStatus": pgStatus,
      "pgResponseMessage": pgResponseMessage,
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if(response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception(
          'Order failed: ${response.statusCode} - ${response.body}'
        );
      }       
    } catch (e) {
      throw Exception('Error submitting order: $e');
    }
  }
}