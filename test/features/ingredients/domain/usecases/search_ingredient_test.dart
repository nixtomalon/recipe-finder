import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/domain/usecases/search_ingredient.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchIngredientUseCase searchIngredientUseCase;
  late MockIngredientRepository mockIngredientRepository;

  final testIngredients = [
    IngredientEntity(name: 'Apple', image: 'url'),
    IngredientEntity(name: 'Apple', image: 'url'),
  ];

  final testIngredientName = 'Apple';

  setUp(() {
    mockIngredientRepository = MockIngredientRepository();
    searchIngredientUseCase = SearchIngredientUseCase(mockIngredientRepository);
  });

  test('should search ingredient from repository', () async {
    // arrange
    when(mockIngredientRepository.searchIngredient(testIngredientName))
        .thenAnswer(
            (_) async => DataSuccess<List<IngredientEntity>>(testIngredients));

    // act
    final result = await searchIngredientUseCase(params: testIngredientName);

    // assert
    expect(result.data, testIngredients);
  });
}
