import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/data/models/ingredient.dart';
import 'package:recipe_finder/features/ingredients/data/repositories/ingredient_repository_impl.dart';
import 'package:retrofit/dio.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockIngredientApiService mockIngredientApiService;
  late IngredientRepositoryImpl ingredientRepositoryImpl;

  setUp(() {
    mockIngredientApiService = MockIngredientApiService();
    ingredientRepositoryImpl =
        IngredientRepositoryImpl(mockIngredientApiService);
  });

  group('search ingredient', () {
    test(
        'should return instance of DatafFailed when a call to a data source is unsuccessfull',
        () async {
      //arrange
      final query = 'apple';

      when(mockIngredientApiService.searchIngredient(
        query: anyNamed('query'),
        apiKey: anyNamed('apiKey'),
        number: anyNamed('number'),
      )).thenThrow(MockDioException());

      //act
      final result = await ingredientRepositoryImpl.searchIngredient(query);

      //assert
      expect(result, isA<DataFailed>());
    });

    test(
        'should return list of Ingredient Model when a call to a data source is successfull',
        () async {
      //arrange
      final query = 'apple';
      final testIngredientModel =
          IngredientModel(name: 'apple', image: 'apple.jpg');
      final successResponse = Response(
        statusCode: HttpStatus.ok,
        requestOptions: RequestOptions(),
        data: [testIngredientModel],
      );

      when(mockIngredientApiService.searchIngredient(
        query: anyNamed('query'),
        apiKey: anyNamed('apiKey'),
        number: anyNamed('number'),
      )).thenAnswer((_) async => HttpResponse<List<IngredientModel>>(
          [testIngredientModel], successResponse));

      //act
      final result = await ingredientRepositoryImpl.searchIngredient(query);

      //assert
      expect(result.data, equals([testIngredientModel]));
    });
  });
}
