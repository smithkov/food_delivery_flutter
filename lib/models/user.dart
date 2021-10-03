class User {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String token;
  final String phone;
  final String stripeCustomerId;
  final String firstAddress;
  final String email;
  final String postCode;
  final bool error;

  User(
      {this.id,
      this.firstName,
      this.fullName,
      this.stripeCustomerId,
      this.phone,
      this.firstAddress,
      this.email,
      this.role,
      this.postCode,
      this.lastName,
      this.error,
      this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["firstName"] = firstName;
    data["fullName"] = fullName;
    data["lastName"] = lastName;
    data["stripeCustomerId"] = stripeCustomerId;
    data["token"] = token;
    data["role"] = role;
    data["phone"] = phone;
    data["postCode"] = postCode;
    data["firstAddress"] = firstAddress;
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    bool hasError = json == null ? true : false;
    return User(
        id: hasError ? "" : json['id'] as String,
        firstName: hasError ? "" : json['firstName'] as String,
        fullName: hasError ? "" : json['fullName'] as dynamic,
        role: hasError ? "" : json['role'] as dynamic,
        phone: hasError ? "" : json["phone"] as String,
        email: hasError ? "" : json["email"] as String,
        lastName: hasError ? "" : json["lastName"] as String,
        firstAddress: hasError ? "" : json["firstAddress"] as String,
        error: hasError ? true : json['error'] as bool,
        postCode: hasError ? "" : json['postCode'] as String,
        token: hasError ? "" : json['token'] as dynamic);
  }
  // toJSONEncodableList() {
  //   List<User> items = [];
  //   return items.map((item) {
  //     return item.toJSONEncodable();
  //   }).toList();
  // }
}
