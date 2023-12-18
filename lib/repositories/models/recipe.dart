class Recipe {
  int? id;
  String? title;
  String? image;
  int? likes;
  List<MissedIngredients>? missedIngredients = [];
  List<UsedIngredients>? usedIngredients = [];
  List<UnusedIngredients>? unusedIngredients = [];

  Recipe({
    this.id,
    this.title,
    this.image,
    this.likes,
    this.missedIngredients,
    this.usedIngredients,
    this.unusedIngredients,
  });

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    likes = json['likes'];

    missedIngredients = (json['missedIngredients'] as List)
        .map((data) => MissedIngredients.fromJson(data))
        .toList();
    usedIngredients = (json['usedIngredients'] as List)
        .map((data) => UsedIngredients.fromJson(data))
        .toList();
    unusedIngredients = (json['unusedIngredients'] as List)
        .map((data) => UnusedIngredients.fromJson(data))
        .toList();
  }
}

class MissedIngredients {
  int? id;
  double? amount;
  String? unit;
  String? orignal;
  String? image;

  MissedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    orignal = json['name'];
    image = json['image'];
  }
}

class UsedIngredients {
  int? id;
  double? amount;
  String? unit;
  String? orignal;
  String? image;

  UsedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    orignal = json['name'];
    image = json['image'];
  }
}

class UnusedIngredients {
  int? id;
  double? amount;
  String? unit;
  String? orignal;
  String? image;

  UnusedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    orignal = json['name'];
    image = json['image'];
  }
}
