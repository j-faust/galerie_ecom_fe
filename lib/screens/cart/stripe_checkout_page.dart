import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class StripeCheckoutPage extends StatefulWidget {
  final double amount;

  const StripeCheckoutPage({Key? key, required this.amount}) : super(key: key);

  @override
  State<StripeCheckoutPage> createState() => _StripeCheckoutPageState();
}

class _StripeCheckoutPageState extends State<StripeCheckoutPage> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startCheckout();
  }

  Future<void> _startCheckout() async {
    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/create-checkout-session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': widget.amount}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final checkoutUrl = data['url'];

        if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
          await launchUrl(
            Uri.parse(checkoutUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw Exception('Could not launch Checkout URL');
        }
      } else {
        throw Exception('Failed to create Checkout session');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error: $_error',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const Text('Redirecting to payment...'),
      ),
    );
  }
}
