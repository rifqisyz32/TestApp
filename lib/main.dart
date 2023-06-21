import 'package:test_app/pages/list_view_page.dart';
import 'package:test_app/pages/product_page.dart';
import 'package:test_app/pages/product_detail_page.dart';
import 'package:test_app/providers/product_provider.dart';
import 'pages/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    TestApp(),
  );
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ProductProvider(),
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
            ProductPage.routeName: (context) => ProductPage(),
            ProductDetailPage.routeName: (context) => ProductDetailPage(),
          },
        ),
      );
}
