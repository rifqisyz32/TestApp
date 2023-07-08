import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/auth_page.dart';
import 'package:test_app/providers/auth_provider.dart';

import 'pages/home_page.dart';
import 'pages/tab_page.dart';
import 'pages/http_page.dart';
import 'pages/list_view_page.dart';
import 'pages/players/add_player_page.dart';
import 'pages/players/detail_player_page.dart';
import 'pages/players/player_page.dart';
import 'pages/products/cart_page.dart';
import 'pages/products/product_detail_page.dart';
import 'pages/products/product_page.dart';

import 'providers/player_provider.dart';
import 'providers/http_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(
    TestApp(),
  );
}

class TestApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    fontFamily: 'SF-Pro-Display',
    primarySwatch: Colors.blue,
  );

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
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HTTPProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, PlayerProvider>(
            create: (context) => PlayerProvider(),
            update: (context, auth, player) =>
                player!..updateToken(auth.token, auth.userId),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) => MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: auth.isAuth
                ? ProductPage()
                : FutureBuilder(
                    future: auth.autoLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return LoginPage();
                    },
                  ),
            // initialRoute: ProductPage.routeName,
            routes: {
              LoginPage.routeName: (context) => LoginPage(),
              HomePage.routeName: (context) => HomePage(),
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
        ),
      );
}
