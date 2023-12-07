import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/repositories/api_repository.dart';
import 'package:recipe_finder/repositories/models/ingredient.dart';
import 'package:recipe_finder/repositories/models/recipe.dart';

import 'api_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FoodApiRepositoryImpl>()])
void main() {
  group('searchIngredients', () {
    test('returns an ingredients if the http call completes successfully',
        () async {
      final ingredients = MockFoodApiRepositoryImpl();
      final expectedListOfIngredients =
          Ingredient(name: 'apple', image: 'image');
      when(ingredients.searchIngredient(expectedListOfIngredients.name))
          .thenAnswer((_) async => [expectedListOfIngredients]);

      // Act
      final actualResult =
          await ingredients.searchIngredient(expectedListOfIngredients.name);

      // Assert

      expect(actualResult.first, expectedListOfIngredients);
    });
  });

  group('getRecipes', () {
    test('returns a list of recipes if the http call completes successfully',
        () async {
      final recipes = MockFoodApiRepositoryImpl();
      final expectedListOfRecipes = Recipe(
          id: 1,
          title: 'Apple Pie',
          image: 'image',
          missedIngredients: [],
          usedIngredients: [],
          unusedIngredients: []);
      when(recipes.getRecipes([expectedListOfRecipes.title!]))
          .thenAnswer((_) async => [expectedListOfRecipes]);

      // Act
      final actualResult =
          await recipes.getRecipes([expectedListOfRecipes.title!]);

      // Assert
      expect(actualResult.first, expectedListOfRecipes);
    });
  });
}
