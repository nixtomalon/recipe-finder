import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_api_service.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late RecipeApiService recipeApiService;

  setUp(() {
    mockDio = MockDio();
    recipeApiService = RecipeApiService(mockDio);
  });

  test('should return list of dishes when the statuscode is 200', () async {
    //arrange
    final query = ['apple'];

    when(mockDio.options).thenReturn(BaseOptions());

    when(mockDio.fetch<List<dynamic>>(any)).thenAnswer(
      (_) async => Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    when(mockDio.get(
      '${baseUrl}recipes/findByIngredients?ingredients=$query&apiKey=$apiKey&number=5',
    )).thenAnswer(
      (_) async => Response(
        data: readJson('helpers/dummy_data/dummy_dishes_response_list.json'),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final result = await recipeApiService.getRecipes(ingredients: query);

    // assert
    expect(result.data, isA<List<RecipeModel>>());
  });
}
