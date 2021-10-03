import 'package:flutter/foundation.dart';
import '../models/productCart.dart';

class ShopCart {
  String shopId;
  double grandTotal;

  List<ProductCart> products = [];

  ShopCart({this.shopId});

  void addProduct(
      {String shopId,
      String id,
      String name,
      int quantity,
      double price,
      String desc,
      String weight,
      String photo}) {
    products.add(ProductCart(
        shopId: shopId,
        name: name,
        id: id,
        quantity: quantity,
        price: price,
        desc: desc,
        weight: weight,
        photo: photo));
  }

  List<ProductCart> getProducts() {
    return products;
  }
}
