import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/ingredients/data/models/ingredient.dart';
import 'package:retrofit/retrofit.dart';

part 'ingredient_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class IngredientApiService {
  factory IngredientApiService(Dio dio) = _IngredientApiService;

  @GET('food/ingredients/autocomplete')
  Future<HttpResponse<List<IngredientModel>>> searchIngredient({
    @Query('query') String? query,
    @Query('apiKey') String? apiKey,
    @Query('number') int? number,
  });
}
