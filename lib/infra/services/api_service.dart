import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../repositories/models/ingredient.dart';
import '../../repositories/models/recipe.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.spoonacular.com/")
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET('food/ingredients/autocomplete')
  Future<List<Ingredient>> searchIngredient(@Query('query') String query,
      @Query('apiKey') String apiKey, @Query('number') int number);

  @GET('recipes/findByIngredients')
  Future<List<Recipe>> getRecipes(
      @Query('apiKey') String apiKey,
      @Query('ingredients') List<String> ingredients,
      @Query('number') int number);
}
