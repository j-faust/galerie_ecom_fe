import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderConfirmationScreen extends StatelessWidget{
  final Order order; 

  const OrderConfirmationScreen({Key? key, required this.order}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.green[50],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "🎉 Order Placed Successfully!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text("Order ID: ${order.orderId}"),
                Text("Order Placed: ${order.orderDate}"),
                Text("Status: ${order.orderStatus}"),
                Text("Total: \$${order.totalAmount.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

}