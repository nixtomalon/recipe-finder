import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe.dart';
import 'package:recipe_finder/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:retrofit/dio.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipeApiService mockRecipeApiService;
  late RecipeRepositoryImpl recipeRepositoryImpl;

  setUp(() {
    mockRecipeApiService = MockRecipeApiService();
    recipeRepositoryImpl = RecipeRepositoryImpl(mockRecipeApiService);
  });

  group('test get recipe repository implementation', () {
    test(
        'should return instance of DatafFailed when a call to a data source is unsuccessfull',
        () async {
      //arrange
      when(mockRecipeApiService.getRecipes(
        ingredients: anyNamed('ingredients'),
        apiKey: anyNamed('apiKey'),
        number: anyNamed('number'),
      )).thenThrow(MockDioException());

      //act
      final result = await recipeRepositoryImpl.getRecipes(['apple']);

      //assert
      expect(result, isA<DataFailed>());
    });

    test(
        'should return list of recipe model when a call to a data source is successfull',
        () async {
      //arrange
      final query = ['apple'];
      const testRecipeModel = RecipeModel(
        id: 1,
        title: 'apple jelly',
        image: 'apple-jelly.jpg',
        likes: 1,
        missedIngredients: null,
        usedIngredients: null,
        unusedIngredients: null,
      );
      final successResponse = Response(
        statusCode: HttpStatus.ok,
        requestOptions: RequestOptions(),
        data: [testRecipeModel],
      );

      when(mockRecipeApiService.getRecipes(
        ingredients: anyNamed('ingredients'),
        apiKey: anyNamed('apiKey'),
        number: anyNamed('number'),
      )).thenAnswer((_) async =>
          HttpResponse<List<RecipeModel>>([testRecipeModel], successResponse));

      //act
      final result = await recipeRepositoryImpl.getRecipes(query);

      //assert
      expect(result.data, equals([testRecipeModel]));
    });
  });
}
