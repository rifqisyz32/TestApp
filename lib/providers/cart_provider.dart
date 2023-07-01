import 'package:flutter/material.dart';
import 'package:test_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _maps = {};

  Map<String, CartModel> get map => _maps;

  int get totalItem => _maps.length;

  double get totalPrice {
    var total = 0.0;
    _maps.forEach((key, cartModel) {
      total += cartModel.quantity * cartModel.price;
    });
    return total;
  }

  void addCart(String productId, String title, double price) {
    if (_maps.containsKey(productId)) {
      _maps.update(
        productId,
        (value) => CartModel(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity + 1),
      );
    } else {
      _maps.putIfAbsent(
        productId,
        () => CartModel(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }
}
