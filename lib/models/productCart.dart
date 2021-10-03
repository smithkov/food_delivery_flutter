class ProductCart {
  String id;
  String name;
  double price;
  int quantity;
  double total;
  String shopId;

  String photo;
  String desc;
  String weight;
  ProductCart(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.total,
      this.shopId,
      this.photo,
      this.desc,
      this.weight});
}
