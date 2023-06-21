import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _allProduct = List.generate(
    20,
    (index) => ProductModel(
      id: "id_${index + 1}",
      imageUrl: "https://picsum.photos/id/$index/200",
      title: "Product ${index + 1}",
      name: faker.person.name(),
      description: faker.lorem.sentence(),
      price: 10 + Random().nextInt(100).toDouble(),
    ),
  );

  List<ProductModel> get allProduct => [..._allProduct];

  ProductModel findById(productId) => _allProduct
      .firstWhere((productProvider) => productProvider.id == productId);
}
