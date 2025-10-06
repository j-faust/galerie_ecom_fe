import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/screens/product/product_screen.dart';
import 'package:galerie_ecom_fe/screens/auth/profile_screen.dart';
import 'package:galerie_ecom_fe/screens/cart/cart_screen.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import 'package:galerie_ecom_fe/services/cart_service.dart';
import 'package:galerie_ecom_fe/models/cart.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProductScreen(),
    const CartScreen(),
    UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // Load persisted cart count on startup
    CartService().loadCart();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SpatterAppBar(title: 'Galerie'),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.draw),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                ValueListenableBuilder<int>(
                  valueListenable: CartNotifier.cartCount,
                  builder: (context, count, _) {
                    if (count == 0) return const SizedBox.shrink();
                    return Positioned(
                      right: -6,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
