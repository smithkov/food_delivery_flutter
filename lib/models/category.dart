class CategoryModel {
  final String id;
  final String name;
  final String display;
  final String imagePath;

  CategoryModel({this.id, this.name, this.display, this.imagePath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] as String,
      display: json['display'] as String,
      imagePath: json['imagePath'] as String,
      //numberOfItems: json['numberOfItems'] as String
    );
  }
}
