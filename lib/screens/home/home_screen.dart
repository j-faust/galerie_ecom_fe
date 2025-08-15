import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/screens/product/product_screen.dart';
import 'package:galerie_ecom_fe/screens/auth/profile_screen.dart';
import 'package:galerie_ecom_fe/screens/cart/cart_screen.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';

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

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  //_prodService.getCurrentCart().then((c) {
  //    cart = c;
  //  });

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.draw),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
