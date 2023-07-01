import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/product_model.dart';
import 'package:test_app/pages/products/product_detail_page.dart';
import 'package:test_app/providers/cart_provider.dart';
import 'package:test_app/providers/product_provider.dart';

class ProductGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context).allProduct;

    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: productData.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: productData[index],
        child: ProductWidget(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: Consumer<ProductModel>(
            builder: (context, productModel, child) => IconButton(
              icon: (productModel.isFavorite)
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border_outlined),
              onPressed: () {
                productModel.setFavorite();
              },
            ),
          ),
          title: Text(
            productModel.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Added to Cart"),
                  duration: Duration(seconds: 1),
                ),
              );
              cartProvider.addCart(
                  productModel.id, productModel.title, productModel.price);
            },
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailPage.routeName,
              arguments: productModel.id),
          child: Image.network(
            productModel.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
