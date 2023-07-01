import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/pages/http_page.dart';
import 'package:test_app/pages/list_view_page.dart';
import 'package:test_app/pages/players/player_page.dart';
import 'package:test_app/pages/products/cart_page.dart';
import 'package:test_app/pages/tab_page.dart';
import 'package:test_app/providers/cart_provider.dart';
import 'package:test_app/widgets/cart_badge.dart';
import 'package:test_app/widgets/product_widget.dart';

class ProductPage extends StatelessWidget {
  static const routeName = '/product_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 160,
              color: Colors.pinkAccent[400],
              alignment: Alignment.bottomLeft,
              child: Text(
                "Drawer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.shopping_bag_outlined,
                size: 24,
              ),
              title: Text(
                "Product Page",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt_outlined,
                size: 24,
              ),
              title: Text(
                "List Page",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.tab_outlined,
                size: 24,
              ),
              title: Text(
                "Tab Page",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TabPage(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.http_outlined,
                size: 24,
              ),
              title: Text(
                "HTTP Method Page",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HTTPPage(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                size: 24,
              ),
              title: Text(
                "Player Page",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PlayerPage(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ProductGridWidget(),
    );
  }
}
