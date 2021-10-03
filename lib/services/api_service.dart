import 'dart:convert';
import '../models/shop.dart';
import '../models/user.dart';
import '../models/item.dart';
import '../models/previousOrder.dart';
import '../models/category.dart';
import 'package:http/http.dart';
import '../utility/constant.dart';
import '../models/serialize/shopSerial.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ApiService {
  dynamic getToken() async {
    return await FlutterSession().get("token");
  }

  static dynamic getTempId() async {
    return await FlutterSession().get("tempId");
  }

  static dynamic getUserId() async {
    return await FlutterSession().get("userId");
  }

  Future<List<Shop>> getShops() async {
    Response res = await post(apiUrl + '/storeListingForMobile');
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"];

    List<Shop> shops = data.map((dynamic item) => Shop.fromJson(item)).toList();
    return shops;
//    } else {
//      throw "Failed to load shops list";
//    }
  }

  static Future<ShopSerial> retriveCart(String shopId) async {
    var tempId = await getTempId();

    final Map postData = {"tempId": tempId.toString(), "shopId": shopId};
    Response response = await http.post(
      apiUrl + '/findByShopIdForMobile',
      headers: {"Content-Type": "application/json"},
      body: json.encode(postData),
    );

    Map<String, dynamic> data = json.decode(response.body);

    var items = ShopSerial.fromJson(data);
    return items;
  }

  Future<List<Item>> getProductByShop(String shopId) async {
    final Map postData = {
      "shopId": shopId,
    };
    Response res = await http.post(
      apiUrl + '/findProductByShopIdForMobile',
      headers: {"Content-Type": "application/json"},
      body: json.encode(postData),
    );
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"];
    print(data);
    print("printng data");
    List<Item> items = data.map((dynamic item) => Item.fromJson(item)).toList();
    return items;
  }

  Future<List<PreviousOrder>> userOrders() async {
    String userId = await getUserId();

    final Map postData = {
      "userId": userId,
    };
    Response res = await http.post(
      apiUrl + '/user/transaction',
      headers: {"Content-Type": "application/json"},
      body: json.encode(postData),
    );
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"];

    List<PreviousOrder> items =
        data.map((dynamic item) => PreviousOrder.fromJson(item)).toList();

    return items;
  }

  Future<List<CategoryModel>> getCategories() async {
    Response res = await get(apiUrl + '/categories');
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"];
    List<CategoryModel> categories =
        data.map((dynamic item) => CategoryModel.fromJson(item)).toList();
    return categories;
  }

  static Future<bool> updateAddress(
      {String firstAddress, String phone, String postCode}) async {
    try {
      var userId = await getUserId();
      Map data = {
        'firstAddress': firstAddress,
        'phone': phone,
        'postCode': postCode,
        'userId': userId
      };

      final Response response = await post(
        '$apiUrl/addressUpdateForMobile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body) as Map<String, dynamic>;

      return user["error"] as bool;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<bool> updateUser(
      {String firstName,
      String lastName,
      String firstAddress,
      String postCode,
      String phone}) async {
    try {
      var userId = await getUserId();

      Map data = {
        'lastName': lastName,
        'firstName': firstName,
        'userId': userId,
        'phone': phone,
        'postCode': postCode,
        'firstAddress': firstAddress
      };

      final Response response = await post(
        '$apiUrl/userUpdateForMobile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body) as Map<String, dynamic>;

      return user["error"] as bool;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<bool> confirmTransaction({
    String shopId,
  }) async {
    try {
      var tempId = await getTempId();
      var userId = await getUserId();

      Map data = {
        'tempId': tempId.toString(),
        'shopId': shopId,
        'userId': userId.toString()
      };

      final Response response = await post(
        '$apiUrl/transactionForMobile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body) as Map<String, dynamic>;

      return user["error"] as bool;
    } catch (error) {
      throw error;
    }
  }

  static Future<bool> deliveryMessage({String message, String shopId}) async {
    try {
      var tempId = await getTempId();
      print(tempId.toString());
      print(shopId);
      print(DateTime.now());
      print("print details");
      Map data = {
        'message': message,
        'tempId': tempId.toString(),
        'shopId': shopId,
        'deliveryDay': "",
        'deliveryTime': DateTime.now().toString()
      };

      final Response response = await post(
        '$apiUrl/order/messageUpdate',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body) as Map<String, dynamic>;

      return user["error"] as bool;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<User> getUserData() async {
    try {
      var userId = await getUserId();
      Map data = {
        'id': userId.toString(),
      };

      final Response response = await post(
        '$apiUrl/findUserById',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body) as Map<String, dynamic>;
      var items = User.fromJson(user);
      return items;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      Map data = {
        'email': email,
        'password': password,
      };

      final Response response = await post(
        '$apiUrl/user/loginForMobile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var user = json.decode(response.body)['data'] as Map<String, dynamic>;
      var items = User.fromJson(user);
      return items;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> phoneVerify(
      String phoneCode, String userId) async {
    try {
      Map data = {
        'phoneCode': phoneCode,
        'userId': userId,
      };
      print(apiUrl);
      final Response response = await post(
        '$apiUrl/user/verifyPhone',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      bool hasError = true;

      hasError = json.decode(response.body)['error'] as bool;
      return {"hasError": hasError};
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // static Future<Map<String, dynamic>> paymentIntent(
  //     {String amount, String shopId}) async {
  //   String userId = await getUserId();
  //   try {
  //     Map data = {'amount': amount, 'shopId': shopId, 'userId': userId};

  //     final Response response = await post(
  //       '$apiUrl/paymentIntentForMobile',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );
  //     return json.decode(response.body);
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }
  // Future<List<Category>> getCategories() async {
  //   Response res = await get(apiUrl + '/categories');
  //   Map<String, dynamic> map = json.decode(res.body);
  //   List<dynamic> data = map["data"];
  //   List<Category> categories =
  //       data.map((dynamic item) => Category.fromJson(item)).toList();
  //   return categories;
  // }

  Future<Map<String, dynamic>> register(String email, String password,
      String firstName, String lastName, String phone) async {
    try {
      Map data = {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'isForMobile': true
      };

      final Response response = await post(
        '$apiUrl/user/register',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      bool hasError = true;
      var dataObj = {};

      hasError = json.decode(response.body)['error'] as bool;
      if (!hasError)
        dataObj = json.decode(response.body)['data'] as Map<String, dynamic>;
      return {"hasError": hasError, "obj": dataObj};
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<Map<String, dynamic>> fetchDeliveryPriceByDistance(
      String distance, String shopId) async {
    try {
      Map data = {
        'distance': distance,
        'shopId': shopId,
      };

      final Response response = await post(
        '$apiUrl/fetchDeliveryPriceByDistance',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var dataObj = {};

      dataObj = json.decode(response.body)['data'] as Map<String, dynamic>;
      return dataObj;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // static Future<String> createStripeAccount(String userId) async {
  //   try {
  //     Map data = {'id': userId};

  //     final Response response = await post(
  //       '$apiUrl/stripe/createCustomer',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );

  //     var customerId = json.decode(response.body)['id'] as String;
  //     return customerId;
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // static Future<Map<String, dynamic>> createCard(
  //     {String userId,
  //     String stripeId,
  //     String expMonth,
  //     String expYear,
  //     String cvc,
  //     String cardNo}) async {
  //   try {
  //     Map data = {
  //       'id': userId,
  //       'expMonth': expMonth,
  //       'expYear': expYear,
  //       'cvc': cvc,
  //       'cardNo': cardNo,
  //       'userId': userId,
  //       'stripeId': stripeId,
  //     };

  //     final Response response = await post(
  //       '$apiUrl/stripe/createCard',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );

  //     return json.decode(response.body);
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // static Future<Map<String, dynamic>> markDefaultCard({
  //   String id,
  // }) async {
  //   //Id means card's primary key

  //   String userId = await getUserId();
  //   try {
  //     Map data = {
  //       'userId': userId,
  //       'id': id,
  //     };

  //     final Response response = await post(
  //       '$apiUrl/stripe/markAsDefault',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );

  //     return json.decode(response.body);
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  static Future<Map<String, dynamic>> stripeSession(
      {String shopId, String amount}) async {
    //Id means card's primary key

    try {
      Map data = {'shopId': shopId, 'amount': amount, 'isForMobile': "true"};

      final Response response = await post(
        '$apiUrl/transaction/session',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      return json.decode(response.body);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // static Future<Map<String, dynamic>> deleteCart({String shopId}) async {
  //   var tempId = await getTempId();
  //   try {
  //     Map data = {'shopId': shopId, 'tempId': tempId.toString()};

  //     final Response response = await post(
  //       '$apiUrl/deleteOrder',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );

  //     return json.decode(response.body);
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // static Future<List<CardModel>> userCards({String userId}) async {
  //   final Map postData = {
  //     "userId": userId,
  //   };
  //   var response = await http.post(
  //     apiUrl + '/userCards',
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(postData),
  //   );
  //   //return parsePosts(response.body);
  //   return compute(parsePosts, response.body);
  // }

  // static List<CardModel> parsePosts(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<CardModel>((json) => CardModel.fromJson(json)).toList();
  // }

  Future<Shop> getShopById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return Shop.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Shop> createShop(Shop shop) async {
    Map data = {
      'shopName': shop.shopName,
      'logo': shop.discountAmount,
      'banner': shop.banner,
      'postCode': shop.deliveryPrice,
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Shop.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Shop> updateShop(String id, Shop shop) async {
    Map data = {
      'shopName': shop.shopName,
      'logo': shop.discountAmount,
      'banner': shop.banner,
      'postCode': shop.deliveryPrice,
    };

    final Response response = await put(
      '$apiUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Shop.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteShop(String id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}
