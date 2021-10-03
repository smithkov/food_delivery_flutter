import '../models/shop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  final String id;
  final String name;
  final String price;
  final String photo;
  final String desc;
  final String weight;
  final Shop shop;

  Item(
      {this.id,
      this.name,
      this.price,
      this.photo,
      this.desc,
      this.weight,
      this.shop});
  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
//  factory Item.fromJson(Map<String, dynamic> json){
//    return Item(
//
//      name:json['name'] as String,
//      price:json['price'] as String,
//      photo:json['photo'] as String,
//      desc:json['desc'] as String,
//      weight:json['weight'] as String,
//      shop: json['VirtualShop'] as dynamic
//      //numberOfItems: json['numberOfItems'] as String
//    );
//  }
}
