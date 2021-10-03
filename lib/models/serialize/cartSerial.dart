class CartSerial {
  String id;
  String name;
  dynamic price;
  dynamic quantity;

  CartSerial({this.id, this.name, this.price, this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["quantity"] = quantity;
    return data;
  }

  factory CartSerial.fromJson(Map<String, dynamic> json) {
    return CartSerial(
        id: json['id'] as String,
        name: json['name'] as String,
        price: json['price'] as dynamic,
        quantity: json['quantity'] as dynamic);
  }
}
