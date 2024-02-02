import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_api_service.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeApiService _recipeApiService;

  RecipeRepositoryImpl(this._recipeApiService);

  @override
  Future<DataState<List<RecipeModel>>> getRecipes(
      List<String> ingredients) async {
    try {
      final httpResponse = await _recipeApiService.getRecipes(
        ingredients: ingredients,
        apiKey: apiKey,
        number: 15,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
