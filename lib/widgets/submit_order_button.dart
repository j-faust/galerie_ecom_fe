import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/screens/order_confirmation_screen.dart';
import '../services/order_service.dart';
import '../models/order.dart';


class SubmitOrderButton extends StatefulWidget {
  final String jwtToken;
  final String paymentMethod;
  final int addressId; 
  final String pgName;
  final String pgPaymentId; 
  final String pgStatus;
  final String pgResponseMessage;

  const SubmitOrderButton({
    Key? key,
    required this.jwtToken,
    required this.paymentMethod,
    required this.addressId,
    required this.pgName,
    required this.pgPaymentId,
    required this.pgStatus,
    required this.pgResponseMessage,
  }) : super(key: key);

  @override
 SubmitOrderButtonState createState() => SubmitOrderButtonState();

}

class SubmitOrderButtonState extends State<SubmitOrderButton> {
  bool _isLoading = false;
  String? _errorMessage;
  Order? _order;

  Future<void> _submitOrder() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final order = await OrderService.submitOrder(
        jwtToken: widget.jwtToken,
        paymentMethod: widget.paymentMethod,
        addressId: widget.addressId,
        pgName: widget.pgName,
        pgPaymentId: widget.pgPaymentId,
        pgStatus: widget.pgStatus,
        pgResponseMessage: widget.pgResponseMessage,
      );

      if(!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(order: order),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_isLoading) const CircularProgressIndicator(),
        if(_errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
            ),
        if(_order != null) 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "🎉 Order Placed Successfully!",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text("Order ID: ${_order!.orderId}"),
                    Text("Status: ${_order!.orderStatus}"),
                    Text("Total: \$${_order!.totalAmount.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ),
          ),
          if(_isLoading && _order == null)
            ElevatedButton(onPressed: _submitOrder, child: const Text("Submit Order"),
          ),
      ],
    );
  }
}