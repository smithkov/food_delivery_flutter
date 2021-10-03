import 'package:json_annotation/json_annotation.dart';
import 'item.dart';
part 'shop.g.dart';

@JsonSerializable()
class Shop {
  final String id;
  final String shopName;
  final String banner;
  final bool isPreOrder;
  final String deliveryPrice;
  final String discountAmount;
  final String minOrder;
  final String percentageDiscount;
  final String logo;
  final String phone;
  final String stripeAccount;
  final String longitude;
  final String latitude;
  final String deliveryDistance;
  final bool hasMultipleDelivery;

  Shop(
      {this.id,
      this.shopName,
      this.banner,
      this.isPreOrder,
      this.deliveryPrice,
      this.discountAmount,
      this.minOrder,
      this.percentageDiscount,
      this.logo,
      this.phone,
      this.stripeAccount,
      this.longitude,
      this.latitude,
      this.deliveryDistance,
      this.hasMultipleDelivery});
  factory Shop.fromJson(Map<String, dynamic> data) => _$ShopFromJson(data);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
//  factory Shop.fromJson(Map<String, dynamic> json){
//    return Shop(
//      id:json['id'] as String,
//      shopName:json['shopName'] as String,
//      minOrder:json['minOrder'] as String,
//      banner:json['banner'] as String,
//      isPreOrder:json['isPreOrder'] as bool,
//      deliveryPrice:json['deliveryPrice'] as String,
//      discountAmount:json['discountAmount'] as String,
//      percentageDiscount:json['percentageDiscount'] as String,
//      logo:json['logo'] as String,
//    );
//  }
}
