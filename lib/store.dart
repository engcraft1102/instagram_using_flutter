import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Store1 extends ChangeNotifier {
  var follower = 0;
  var isFollow = false;

  follow() {
    isFollow == true ? follower-- : follower++;
    isFollow = !isFollow;
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier {
  var name = 'winter.olaf';
  var profileImage = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    profileImage = jsonDecode(result.body);
    notifyListeners();
  }

  changeName() {
    name = 'john park';
    notifyListeners();
  }
}
