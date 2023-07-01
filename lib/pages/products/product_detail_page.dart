import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/pages/products/cart_page.dart';
import 'package:test_app/providers/cart_provider.dart';
import 'package:test_app/providers/product_provider.dart';
import 'package:test_app/widgets/cart_badge.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product_detail_page';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productData =
        Provider.of<ProductProvider>(context).findById(productId);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Description"),
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, ch) {
              return CartBadge(
                value: value.totalItem.toString(),
                child: ch!,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 240,
            child: Image.network(
              productData.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  productData.title,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "\$${productData.price}",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  productData.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added to Cart"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    cartProvider.addCart(
                        productData.id, productData.title, productData.price);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
