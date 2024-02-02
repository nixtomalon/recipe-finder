import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe.dart';
import 'package:retrofit/retrofit.dart';

part 'recipe_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RecipeApiService {
  factory RecipeApiService(Dio dio) = _RecipeApiService;

  @GET('recipes/findByIngredients')
  Future<HttpResponse<List<RecipeModel>>> getRecipes(
      {@Query('apiKey') String? apiKey,
      @Query('ingredients') List<String>? ingredients,
      @Query('number') int? number});
}
