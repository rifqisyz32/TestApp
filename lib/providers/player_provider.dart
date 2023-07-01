import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/player_model.dart';

class PlayerProvider with ChangeNotifier {
  List<PlayerModel> _allPlayer = [];

  List<PlayerModel> get allPlayer => _allPlayer;

  int get countPlayer => _allPlayer.length;

  PlayerModel selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  Future<void> initialData() async {
    Uri url = Uri.parse(
        "https://fluttertestapp-3f76c-default-rtdb.asia-southeast1.firebasedatabase.app/players.json");

    var getData = await http.get(url);
    var dataResult = json.decode(getData.body) as Map<String, dynamic>;

    dataResult.forEach(
      (key, value) {
        DateTime dateTime = DateFormat("yyyy-mm-dd hh:mm:ss").parse(
          value["createdAt"],
        );
        _allPlayer.add(
          PlayerModel(
            id: key,
            name: value["name"],
            createdAt: dateTime,
            position: value["position"],
            imageUrl: value["imageUrl"],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> addPlayer(String name, position, image) {
    DateTime dateTime = DateTime.now();

    Uri url = Uri.parse(
        "https://fluttertestapp-3f76c-default-rtdb.asia-southeast1.firebasedatabase.app/players.json");

    return http
        .post(
      url,
      body: json.encode(
        {
          "name": name,
          "position": position,
          "imageUrl": image,
          "createdAt": dateTime.toString(),
        },
      ),
    )
        .then(
      (value) {
        _allPlayer.add(
          PlayerModel(
            id: json.decode(value.body)["name"].toString(),
            name: name,
            position: position,
            imageUrl: image,
            createdAt: dateTime,
          ),
        );
        notifyListeners();
      },
    );
  }

  Future<void> deletePlayer(String id) {
    Uri url = Uri.parse(
        "https://fluttertestapp-3f76c-default-rtdb.asia-southeast1.firebasedatabase.app/players/$id.json");

    return http.delete(url).then(
      (value) {
        _allPlayer.removeWhere((element) => element.id == id);
        notifyListeners();
      },
    );
  }

  Future<void> editPlayer(String id, name, position, image) {
    Uri url = Uri.parse(
        "https://fluttertestapp-3f76c-default-rtdb.asia-southeast1.firebasedatabase.app/players/$id.json");

    return http
        .patch(
      url,
      body: json.encode(
        {
          "name": name,
          "position": position,
          "imageUrl": image,
        },
      ),
    )
        .then(
      (value) {
        PlayerModel selectPlayer =
            _allPlayer.firstWhere((element) => element.id == id);
        selectPlayer.name = name;
        selectPlayer.position = position;
        selectPlayer.imageUrl = image;
        notifyListeners();
      },
    );
  }
}
