class Ingredient {
  String? name;
  String? image;

  Ingredient({this.name, this.image});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    image = json['image'] as String;
  }
}