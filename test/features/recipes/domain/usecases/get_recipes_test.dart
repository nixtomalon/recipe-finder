import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/get_recipes.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipeRepository mockRecipeRepository;
  late GetRecipesUseCase getRecipesUseCase;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    getRecipesUseCase = GetRecipesUseCase(mockRecipeRepository);
  });

  test('should get list of dishes from repository', () async {
    //arrange
    final List<String> query = ['apple', 'orange'];
    final testRecipeEntity = RecipeEntity(
      title: '',
      image: '',
      likes: 1,
      missedIngredients: [],
      usedIngredients: [],
      unusedIngredients: [],
    );

    when(mockRecipeRepository.getRecipes(query)).thenAnswer(
        (_) async => DataSuccess<List<RecipeEntity>>([testRecipeEntity]));

    //act
    final result = await getRecipesUseCase(params: query);

    //assert
    expect(result.data, [testRecipeEntity]);
  });
}
