class PreviousOrder {
  final String id;
  final String refNo;
  final String createdAt;
  final String total;

  PreviousOrder({this.id, this.refNo, this.createdAt, this.total});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["refNo"] = refNo;
    data["createdAt"] = createdAt;
    data["total"] = total;

    return data;
  }

  factory PreviousOrder.fromJson(Map<String, dynamic> json) {
    return PreviousOrder(
      id: json['id'] as String,
      refNo: json['refNo'] as String,
      total: json['total'] as String,
      createdAt: json['createdAt'] as String,
      //numberOfItems: json['numberOfItems'] as String
    );
  }
}
