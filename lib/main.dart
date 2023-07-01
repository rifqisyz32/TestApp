import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/players/add_player_page.dart';
import 'package:test_app/pages/players/detail_player_page.dart';
import 'package:test_app/pages/players/player_page.dart';
import 'package:test_app/providers/player_provider.dart';

import 'pages/products/cart_page.dart';
import 'pages/products/product_detail_page.dart';
import 'pages/products/product_page.dart';
import 'pages/list_view_page.dart';
import 'pages/tab_page.dart';
import 'pages/http_page.dart';

import 'providers/http_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(
    TestApp(),
  );
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HTTPProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlayerProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            // brightness: Brightness.dark,
            primarySwatch: Colors.pink,
            fontFamily: 'SFUIText',
          ),
          debugShowCheckedModeBanner: false,
          home: ProductPage(),
          initialRoute: ProductPage.routeName,
          routes: {
            ListPage.routeName: (context) => ListPage(),
            TabPage.routeName: (context) => TabPage(),
            HTTPPage.routeName: (context) => HTTPPage(),
            PlayerPage.routeName: (context) => PlayerPage(),
            AddPlayerPage.routeName: (context) => AddPlayerPage(),
            DetailPlayerPage.routeName: (context) => DetailPlayerPage(),
            ProductPage.routeName: (context) => ProductPage(),
            ProductDetailPage.routeName: (context) => ProductDetailPage(),
            CartPage.routeName: (context) => CartPage(),
          },
        ),
      );
}
