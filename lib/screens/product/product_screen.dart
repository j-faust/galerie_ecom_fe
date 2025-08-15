import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/product.dart';
import 'package:galerie_ecom_fe/screens/product/product_detail_page.dart';
import 'package:galerie_ecom_fe/services/product_service.dart';
import 'package:galerie_ecom_fe/widgets/product_card.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart'; // Adjust the path as needed

enum ProductViewType { list, gallery }
 final ProductService _prodService = ProductService();

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductScreen> {
  ProductViewType _viewType = ProductViewType.list; // Initial view type
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpatterAppBar(
        title: 'Galerie',
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _viewType = ProductViewType.list;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              setState(() {
                _viewType = ProductViewType.gallery;
              });
            },
          ),
        ],
      ),
      body: _viewType == ProductViewType.list
          ? _buildListView()
          : _buildGalleryView(),
    );
  }
 // ✅ These now have access to `this.context` and work properly
  Widget _buildListView() {
    List<Product> products = _prodService.getProducts();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            print(">>> onTap triggered for: ${product.productName}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: ProductCard(product: product),
        );
      },
    );
  }

  Widget _buildGalleryView() {
    List<Product> products = _prodService.getProducts();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return InkWell(
          onTap: () {
            print(">>> onTap triggered for: ${product.productName}");
  
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    product.productImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.productName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[700]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
