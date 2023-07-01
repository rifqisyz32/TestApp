import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  String id, imageUrl, name, title, description;
  double price;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.title,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });

  void setFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
