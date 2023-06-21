import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/product_detail_page.dart';
import 'package:test_app/providers/product_provider.dart';

class productGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allProduct = Provider.of<ProductProvider>(context).allProduct;

    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: allProduct.length,
      itemBuilder: (context, index) => productWidget(
        allProduct[index].id,
        allProduct[index].title,
        allProduct[index].imageUrl,
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

class productWidget extends StatelessWidget {
  final String id, title, imageUrl;

  productWidget(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(ProductDetailPage.routeName, arguments: id),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ));
  }
}
