import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/product_provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/grid_page_detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final ProductData =
        Provider.of<ProductProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Description"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            child: Image.network(
              "${ProductData.imageUrl}",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "${ProductData.title}",
            style: TextStyle(
              fontSize: 36,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "\$${ProductData.price}",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "${ProductData.description}",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
