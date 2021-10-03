import 'dart:math';
import 'package:flutter_session/flutter_session.dart';

import '../utility/constant.dart';

class Conversion {
  static String moneyFormat(double value) {
    return value.toStringAsFixed(2);
  }

  static String moneyFormatForString(String value) {
    if (value == null) {
      return "";
    }
    if (double.tryParse(value) != null) {
      return "£" + double.tryParse(value).toStringAsFixed(2);
    } else
      return "";
  }

  static dynamic getMiles(var lat2, var lon2) async {
    var lat1 = await FlutterSession().get(latitude);
    var lon1 = await FlutterSession().get(longitude);
    var R = 6371; // km
    var dLat = _toRad(lat2 - lat1);
    var dLon = _toRad(lon2 - lon1);
    var _lat1 = _toRad(lat1);
    var _lat2 = _toRad(lat2);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(_lat1) * cos(_lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    return d;
  }

  static dynamic getMiles2(var lat1, var lon1, var lat2, var lon2) {
    print(lat1);
    print(lon1);
    var R = 6371; // km
    var dLat = _toRad(lat2 - lat1);
    var dLon = _toRad(lon2 - lon1);
    var _lat1 = _toRad(lat1);
    var _lat2 = _toRad(lat2);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(_lat1) * cos(_lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    return d.toStringAsFixed(1);
  }

  // Converts numeric degrees to radians
  static dynamic _toRad(dynamic value) {
    return value * pi / 180;
  }
}
