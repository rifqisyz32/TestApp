import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/pages/products/product_page.dart';
import 'package:test_app/providers/http_provider.dart';

class HTTPPage extends StatelessWidget {
  static const routeName = '/http_provider_page';

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<HTTPProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ProductPage(),
              ),
            ),
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ),
        title: Text("HTTP Method"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Information",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Consumer<HTTPProvider>(
                builder: (context, value, child) => CircleAvatar(
                  backgroundImage: NetworkImage(
                    (value.map["avatar"] == null)
                        ? "https://www.clipartmax.com/png/middle/296-2969961_no-image-user-profile-icon.png"
                        : value.map["avatar"],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Consumer<HTTPProvider>(
              builder: (context, value, child) => Text(
                (value.map["id"] == null)
                    ? "ID: Null"
                    : "ID: ${value.map["id"]}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Consumer<HTTPProvider>(
              builder: (context, value, child) => Text(
                (value.map["first_name"] == null ||
                        value.map["last_name"] == null)
                    ? "Full Name: Null"
                    : "${"Full Name: " + value.map["first_name"]} " +
                        value.map["last_name"],
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Consumer<HTTPProvider>(
              builder: (context, value, child) => Text(
                (value.map["email"] == null)
                    ? "Email: Null"
                    : "Email: ${value.map["email"]}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextButton(
              onPressed: () {
                dataProvider.connectAPI(
                  (1 + Random().nextInt(10)).toString(),
                );
              },
              child: Text(
                "Get Data",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
