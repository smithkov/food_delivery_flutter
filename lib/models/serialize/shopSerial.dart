import './cartSerial.dart';

class ShopSerial {
  String tempId;
  dynamic subTotal;
  dynamic total;
  List<CartSerial> orders;
  dynamic offerDiscount;

  ShopSerial(
      {this.tempId,
      this.total,
      this.offerDiscount,
      this.orders,
      this.subTotal});

  factory ShopSerial.fromJson(Map<String, dynamic> json) {
    var list = json['orders'] as List;
    List<CartSerial> orderList =
        list.map((i) => CartSerial.fromJson(i)).toList();
    return ShopSerial(
        tempId: json['tempId'] as String,
        subTotal: json['subTotal'] as dynamic,
        total: json['total'] as dynamic,
        orders: orderList,
        offerDiscount: json['offerDiscount'] as dynamic);
  }
}
