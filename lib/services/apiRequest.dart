import 'package:RecipeFinder/models/ingredient.dart';
import 'package:RecipeFinder/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '4e7973fd01a340d8ae2416e97bdadc96';
const String getIngredientUrl =
    'https://api.spoonacular.com/food/ingredients/autocomplete';
const String getRecipesUrl =
    'https://api.spoonacular.com/recipes/findByIngredients';

const Map<String, String> headers = {"Content-Type": "application/json"};

class RequestData {
  Future<List<Ingredient>> getIngredients(String qry) async {
    var ingredientList = <Ingredient>[];
    try {
      http.Response response = await http.get(
          '$getIngredientUrl?apiKey=$apiKey&query=$qry&number=15',
          headers: headers);

      if (response.statusCode == 200) {
        var datas = jsonDecode(response.body);

        for (var data in datas) {
          Ingredient ingredient = Ingredient.fromJson(data);
          ingredientList.add(ingredient);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return ingredientList;
  }

  Future<List<Recipe>> getRecipes(List<String> ingredient) async {
    var ingredients = json.encode(ingredient);
    var recipes = <Recipe>[];
    try {
      http.Response response = await http.get(
          '$getRecipesUrl?apiKey=$apiKey&ingredients=$ingredients&number=15',
          headers: headers);
      if (response.statusCode == 200) {
        var datas = jsonDecode(response.body);

        for (var data in datas) {
          Recipe recipe = Recipe.fromJson(data);
          recipes.add(recipe);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return recipes;
  }
}
