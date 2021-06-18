class Recipe {
  int id;
  String title;
  String image;
  int likes;
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
    if (json['missedIngredients'].length > 0) {
      missedIngredients = <MissedIngredients>[];
      for (var data in json['missedIngredients']) {
        MissedIngredients missedIngredient = MissedIngredients.fromJson(data);
        missedIngredients.add(missedIngredient);
      }
    }
    if (json['usedIngredients'].length > 0) {
      usedIngredients = <UsedIngredients>[];
      for (var data in json['usedIngredients']) {
        UsedIngredients usedIngredient = UsedIngredients.fromJson(data);
        usedIngredients.add(usedIngredient);
      }
    }
    if (json['unusedIngredients'].length > 0) {
      unusedIngredients = <UnusedIngredients>[];
      for (var data in json['unusedIngredients']) {
        UnusedIngredients usedIngredient = UnusedIngredients.fromJson(data);
        unusedIngredients.add(usedIngredient);
      }
    }
  }
}

class MissedIngredients {
  int id;
  double amount;
  String unit;
  String originalString;

  MissedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    originalString = json['originalString'];
  }
}

class UsedIngredients {
  int id;
  double amount;
  String unit;
  String originalString;

  UsedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    originalString = json['originalString'];
  }
}

class UnusedIngredients {
  int id;
  double amount;
  String unit;
  String originalString;

  UnusedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    unit = json['unit'];
    originalString = json['originalString'];
  }
}
