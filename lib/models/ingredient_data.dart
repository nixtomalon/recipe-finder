import 'package:flutter/foundation.dart';
import 'package:RecipeFinder/models/ingredient.dart';

class IngredientData extends ChangeNotifier {
  List<Ingredient> ingredients = [];

  int get ingredientCount => ingredients.length;

  List get ingredientName {
    List<String> ingredientName = [];
    for (int i = 0; i < ingredients.length; i++) {
      ingredientName.add(ingredients[i].name);
    }
    return ingredientName;
  }

  void addIngredients(String name, String image) {
    ingredients.add(Ingredient(name: name, image: image));
    notifyListeners();
  }

  void removeIngredient(String ingname) {
    ingredients.removeWhere((item) => item.name == ingname);
    notifyListeners();
  }

  var recipeData;

  void provideRecipeData(var data) {
    recipeData = data;
    notifyListeners();
  }

  int get recipeCount => recipeData.length;
}
