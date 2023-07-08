import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/player_model.dart';

class PlayerProvider with ChangeNotifier {
  String urlDB =
      "https://fluttertestapp-3f76c-default-rtdb.asia-southeast1.firebasedatabase.app";

  String? token, userId;

  void updateToken(tokenData, uid) {
    token = tokenData;
    userId = uid;
    notifyListeners();
  }

  List<PlayerModel> _allPlayer = [];

  List<PlayerModel> get allPlayer => _allPlayer;

  int get countPlayer => _allPlayer.length;

  PlayerModel selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  Future<void> initialData() async {
    _allPlayer = [];
    Uri url = Uri.parse(
        '$urlDB/players.json?auth=$token&orderBy="userId"&equalTo="$userId"');

    try {
      var dataResult = await http.get(url);

      if (dataResult.statusCode > 300 || dataResult.statusCode < 200) {
        throw (dataResult.statusCode);
      } else {
        var getData = json.decode(dataResult.body) as Map<String, dynamic>;
        getData.forEach(
          (key, value) {
            PlayerModel data = PlayerModel(
              id: key,
              name: value["name"],
              createdAt:
                  DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["createdAt"]),
              updatedAt:
                  DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["updatedAt"]),
              position: value["position"],
              imageUrl: value["imageUrl"],
            );
            _allPlayer.add(data);
          },
        );
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  addPlayer(String name, position, image) async {
    DateTime dateTime = DateTime.now();

    Uri url = Uri.parse("$urlDB/players.json?auth=$token");

    try {
      final dataResult = await http.post(
        url,
        body: json.encode(
          {
            "name": name,
            "position": position,
            "imageUrl": image,
            "createdAt": dateTime.toString(),
            "updatedAt": dateTime.toString(),
            "userId": userId,
          },
        ),
      );

      if (dataResult.statusCode > 300 || dataResult.statusCode < 200) {
        throw (dataResult.statusCode);
      } else {
        PlayerModel data = PlayerModel(
          id: json.decode(dataResult.body)["name"].toString(),
          name: name,
          position: position,
          imageUrl: image,
          createdAt: dateTime,
          updatedAt: dateTime,
        );

        _allPlayer.add(data);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  deletePlayer(String id) async {
    Uri url = Uri.parse("$urlDB/players/$id.json?auth=$token");

    try {
      final dataResult = await http.delete(url);

      if (dataResult.statusCode > 300 && dataResult.statusCode < 200) {
        throw (dataResult.statusCode);
      } else {
        _allPlayer.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  editPlayer(String id, name, position, image) async {
    Uri url = Uri.parse("$urlDB/players/$id.json?auth=$token");
    DateTime dateTime = DateTime.now();

    try {
      final dataResult = await http.patch(
        url,
        body: json.encode(
          {
            "name": name,
            "position": position,
            "imageUrl": image,
            "updatedAt": dateTime.toString(),
          },
        ),
      );

      if (dataResult.statusCode > 300 && dataResult.statusCode < 200) {
        throw (dataResult.statusCode);
      } else {
        PlayerModel editPlayer =
            _allPlayer.firstWhere((element) => element.id == id);
        editPlayer.name = name;
        editPlayer.position = position;
        editPlayer.imageUrl = image;
        editPlayer.updatedAt = dateTime;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }
}
