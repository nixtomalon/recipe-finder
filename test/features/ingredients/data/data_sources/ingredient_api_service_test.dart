import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/ingredients/data/data_scources/ingredient_api_service.dart';
import 'package:recipe_finder/features/ingredients/data/models/ingredient.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late IngredientApiService ingredientApiService;

  setUp(() {
    mockDio = MockDio();
    ingredientApiService = IngredientApiService(mockDio);
  });

  test('should return list of ingredient model when the response code is 200',
      () async {
    final query = 'apple';

    when(mockDio.options).thenReturn(BaseOptions());

    when(mockDio.fetch<List<dynamic>>(any)).thenAnswer(
      (_) async => Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    when(mockDio.get(
      '${baseUrl}food/ingredients/autocomplete?query=$query&apiKey=$apiKey&number=5',
    )).thenAnswer(
      (_) async => Response(
        data:
            readJson('helpers/dummy_data/dummy_ingredient_response_list.json'),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    // act
    final result = await ingredientApiService.searchIngredient(query: query);

    // assert
    expect(result.data, isA<List<IngredientModel>>());
  });
}
