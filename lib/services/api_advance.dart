import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_session/flutter_session.dart';
import '../utility/constant.dart';

class ApiAdvance {
  dynamic getToken() async {
    return await FlutterSession().get("token");
  }

  static dynamic getTempId() async {
    return await FlutterSession().get("tempId");
  }

  static void addToCart(
      {String id,
      var orders,
      String subTotal,
      String offerDiscount,
      String total,
      String deliveryPrice}) async {
    //Id means card's primary key

    int tempId = await getTempId();
    try {
      var params = {
        'orders': orders,
        'subTotal': subTotal,
        'offerDiscount': offerDiscount,
        'total': total,
        'shopId': id,
        'deliveryPrice': deliveryPrice,
        'tempId': tempId.toString()
      };
      var _dio = Dio();
      Response response = await _dio.post(
        "$apiUrl/cart",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );

      //return json.decode(response.data);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
