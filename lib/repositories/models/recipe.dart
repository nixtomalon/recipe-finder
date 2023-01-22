class Recipe {
  int? id;
  String? title;
  String? image;
  int? likes;
  var missedIngredients;
  var usedIngredients;
  var unusedIngredients;

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
    missedIngredients = json['missedIngredients']
        .map((data) => MissedIngredients.fromJson(data))
        .toList();
    usedIngredients = <UsedIngredients>[];
    unusedIngredients = <UnusedIngredients>[];
    // if (json['missedIngredients'].length > 0) {
    //   for (var data in json['missedIngredients']) {

    //     missedIngredients.add(MissedIngredients.fromJson(data));
    //   }
    // }
    if (json['usedIngredients'].length > 0) {
      for (var data in json['usedIngredients']) {
        UsedIngredients usedIngredient = UsedIngredients.fromJson(data);
        usedIngredients.add(usedIngredient);
      }
    }
    if (json['unusedIngredients'].length > 0) {
      for (var data in json['unusedIngredients']) {
        UnusedIngredients usedIngredient = UnusedIngredients.fromJson(data);
        unusedIngredients.add(usedIngredient);
      }
    }
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
    orignal = json['original'];
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
    orignal = json['original'];
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
    orignal = json['original'];
    image = json['image'];
  }
}
