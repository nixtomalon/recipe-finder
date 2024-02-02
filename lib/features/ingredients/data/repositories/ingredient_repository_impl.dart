import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/data/data_scources/ingredient_api_service.dart';
import 'package:recipe_finder/features/ingredients/data/models/ingredient.dart';
import 'package:recipe_finder/features/ingredients/domain/repositories/ingredient_repository.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientApiService _ingredientApiService;

  IngredientRepositoryImpl(this._ingredientApiService);

  @override
  Future<DataState<List<IngredientModel>>> searchIngredient(
      String? query) async {
    try {
      final httpResponse = await _ingredientApiService.searchIngredient(
        query: query,
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
