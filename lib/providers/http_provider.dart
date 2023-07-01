import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HTTPProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};

  Map<String, dynamic> get map => _map;

  void connectAPI(String id) async {
    Uri url = Uri.parse("https://reqres.in/api/users/$id");

    var getResult = await http.get(url);

    _map = (json.decode(getResult.body))["data"];
    notifyListeners();
  }
}
