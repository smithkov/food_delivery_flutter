// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  String deliveryPrice = json['deliveryPrice'];
  String minOrder = json['minOrder'];
  String discountAmount = json['discountAmount'];
  String percentageDiscount = json['percentageDiscount'];
  String deliveryDistance = json["deliveryDistance"];

  if (minOrder == null) {
    minOrder = "0";
  }
  if (deliveryDistance == null) {
    deliveryDistance = "0";
  }
  if (deliveryPrice == null || deliveryPrice == "NaN") {
    deliveryPrice = "0";
  }

  if (discountAmount == null) {
    discountAmount = "0";
  }

  if (discountAmount == null) {
    discountAmount = "0";
  }

  if (percentageDiscount == null) {
    percentageDiscount = "0";
  }

  return Shop(
      id: json['id'] as String,
      shopName: json['shopName'] as String,
      banner: json['banner'] as String,
      isPreOrder: json['isPreOrder'] as bool,
      deliveryPrice: deliveryPrice,
      discountAmount: discountAmount,
      minOrder: minOrder,
      phone: json['phone'] as String,
      stripeAccount: json['stripeAccount'] as String,
      percentageDiscount: percentageDiscount,
      logo: json['logo'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      deliveryDistance: deliveryDistance,
      hasMultipleDelivery: json['hasMultipleDelivery'] as bool);
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'shopName': instance.shopName,
      'banner': instance.banner,
      'isPreOrder': instance.isPreOrder,
      'deliveryPrice': instance.deliveryPrice,
      'discountAmount': instance.discountAmount,
      'minOrder': instance.minOrder,
      'phone': instance.phone,
      'percentageDiscount': instance.percentageDiscount,
      'logo': instance.logo,
      'stripeAccount': instance.stripeAccount,
    };
