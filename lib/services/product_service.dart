

import 'package:galerie_ecom_fe/models/product.dart';

import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  Future<bool> addProduct(Product product) async {
    final response = await _apiService.post('/product', {
      'username': product.productName,
      'email': product.productDescription,
      'password': product.productImage
    });

    if(response.statusCode == 200) {
      return true;
    } else {
      return false; 
    }
  }

  List<Product> getProducts() {

  List<Product> products = [
      Product(
          productId: '1',
          productName: 'Mona Lisa',
          productDescription: 'Mona Lisa - Original oil on canvas 24 by 36',
          productImage: 'https://cdn.britannica.com/87/2087-050-8B2A01CD/Mona-Lisa-oil-wood-panel-Leonardo-da.jpg',
          price: 25.99),
      Product(
          productId: '2',
          productName: 'Van Gogh Butterfly',
          productDescription: 'Van Gogh-inspired self-portrait & butterfly remixed clipart,',
          productImage: 'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvcGR2YW5nb2doLXNlbGYtcG9ydHJhaXQtbTAxLWpvYjY2MV8yLWwxMDBvNmVmLmpwZw.jpg',
          price: 12.50),
      Product(
          productId: '3',
          productName: 'Country Road',
          productDescription: 'Country Road in Provence by Night, 1889, May 1890,',
          productImage: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Vincent_van_Gogh_-_Road_with_Cypress_and_Star_-_c._12-15_May_1890.jpg/1200px-Vincent_van_Gogh_-_Road_with_Cypress_and_Star_-_c._12-15_May_1890.jpg',
          price: 30.00),
      // Add more products
    ];
    return products;

    }

  }