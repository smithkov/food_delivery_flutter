// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    photo: json['photo'] as String,
    desc: json['desc'] as String,
    weight: json['weight'] as String,
    shop: json['VirtualShop'] == null
        ? null
        : Shop.fromJson(json['VirtualShop'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'photo': instance.photo,
      'desc': instance.desc,
      'weight': instance.weight,
      'shop': instance.shop?.toJson(),
    };
