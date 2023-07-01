import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Text(
                "Total : \$ ${cartData.totalPrice}",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.totalItem,
              itemBuilder: (context, index) => ListTile(
                title: Text(cartData.map.values.toList()[index].title),
                subtitle: Text(
                    "Quantity: ${cartData.map.values.toList()[index].quantity}"),
                trailing:
                    Text("\$ ${cartData.map.values.toList()[index].price}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
