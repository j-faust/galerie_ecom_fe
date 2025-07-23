import 'order_item.dart';
import 'payment.dart';
import 'address.dart';

class Order {
  final String orderId;
  final String email;
  final List<OrderItem> orderItems;
  final DateTime orderDate;
  final Payment payment;
  final double totalAmount;
  final String orderStatus;
  final Address address;

  Order({
    required this.orderId,
    required this.email,
    required this.orderItems,
    required this.orderDate,
    required this.payment,
    required this.totalAmount,
    required this.orderStatus,
    required this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'].toString(),
      email: json['email'],
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      orderDate: DateTime.parse(json['orderDate']),
      payment: Payment.fromJson(json['payment']),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderStatus: json['orderStatus'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'email': email,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
      'orderDate': orderDate.toIso8601String(),
      'payment': payment.toJson(),
      'totalAmount': totalAmount,
      'orderStatus': orderStatus,
      'address': address.toJson(),
    };
  }
}