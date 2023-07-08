import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _idToken, userId;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool isHide = true;

  String? _tempIdToken, tempUserId;
  DateTime? _tempExpiryDate;

  Future<void> tempData() async {
    _idToken = _tempIdToken;
    userId = tempUserId;
    _expiryDate = _tempExpiryDate;

    final prefs = await SharedPreferences.getInstance();
    final mapPrefs = json.encode({
      "token": _idToken,
      "userId": userId,
      "expiryDate": _expiryDate?.toIso8601String(),
    });

    prefs.setString("authData", mapPrefs);

    _autoLogOut();
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _idToken;
    } else {
      return null;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDT_z-uBtymtKJ_SCg3A70UClufr9dCY_E");

    try {
      var dataResult = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      var dataRespond = json.decode(dataResult.body);

      if (dataRespond["error"] != null) {
        throw dataRespond["error"]["message"];
      }

      _tempIdToken = dataRespond["idToken"];
      tempUserId = dataRespond["localId"];
      _tempExpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            dataRespond["expiresIn"],
          ),
        ),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> logIn(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDT_z-uBtymtKJ_SCg3A70UClufr9dCY_E");

    try {
      var dataResult = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      var dataRespond = json.decode(dataResult.body);

      if (dataRespond["error"] != null) {
        throw dataRespond["error"]["message"];
      }

      _tempIdToken = dataRespond["idToken"];
      tempUserId = dataRespond["localId"];
      _tempExpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            dataRespond["expiresIn"],
          ),
        ),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> logOut() async {
    _idToken = null;
    userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    notifyListeners();
  }

  void _autoLogOut() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _tempExpiryDate!.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }

  Future<bool?> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("authData")) {
      return false;
    }

    final myData =
        json.decode(prefs.getString("authData")!) as Map<String, dynamic>;
    final myExpiryDate = DateTime.parse(myData["expiryDate"]);
    if (myExpiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _idToken = myData["token"];
    userId = myData["userId"];
    _expiryDate = myExpiryDate;

    notifyListeners();
    return true;
  }

  void hidePassword() {
    isHide = !isHide;
    notifyListeners();
  }
}
