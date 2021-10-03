import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

final _url = 'https://foodengo.com';
//final _url = 'http://10.0.2.2:8000';
final apiUrl = '$_url/api';
final imageUrl = _url + '/uploads';
final String foodengoColor = '#db2828';
final String blueColor = '#1A4795';
String address = "address";
String longitude = "longitude";
String latitude = "latittude";
final String defaultBannerUrl =
    "https://i.pinimg.com/736x/71/08/34/710834902c903744544b1d334a608d64.jpg";

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

class MyFunctions {
  static int _generateRandom() {
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    return min + randomizer.nextInt(max - min);
  }

  static void generateTempId() async {
    var hasTempId = await FlutterSession().get("tempId");
    if (hasTempId == null) {
      await FlutterSession().set("tempId", _generateRandom());
    }
    var temp = await FlutterSession().get("tempId");
  }

  static Future<dynamic> regenerateTempId() async {
    return await FlutterSession().set("tempId", _generateRandom());
  }
}
