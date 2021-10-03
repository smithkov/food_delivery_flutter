class CardModel {
  String id;
  String userId;
  String month;
  String cardId;
  String year;
  String last4;
  bool isDefault;

  CardModel(
      {this.id,
      this.userId,
      this.month,
      this.cardId,
      this.year,
      this.last4,
      this.isDefault});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      month: json['expMonth'] as String,
      year: json['expYear'] as String,
      last4: json['lastFour'] as String,
      cardId: json['cardId'] as String,
      isDefault: json['isDefault'] as bool,
    );
  }
}
