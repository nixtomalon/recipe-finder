import 'package:dio/dio.dart';
import '../app/constants.dart';
import '../app/utils/api/interceptor.dart';
import '../infra/services/api_service.dart';
import 'models/ingredient.dart';
import 'models/recipe.dart';

abstract class FoodApiRepository {
  Future<List<Ingredient>> searchIngredient(String qry);
  Future<List<Recipe>> getRecipes(List<String> ingredients);
}

class FoodApiRepositoryImpl implements FoodApiRepository {
  FoodApiRepositoryImpl();

  final Api _api = Api(Dio()..interceptors.add(ApiInterceptor()),
      baseUrl: "https://api.spoonacular.com/");

  @override
  Future<List<Ingredient>> searchIngredient(String qry) async {
    return _api.searchIngredient(qry, apiKey, 15);
  }

  @override
  Future<List<Recipe>> getRecipes(List<String> ingredients) async {
    return _api.getRecipes(apiKey, ingredients, 15);
  }
}
