import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testRecipeModel = RecipeModel(
    id: 1,
    title: 'apple jelly',
    image: 'apple-jelly.jpg',
    likes: 1,
    missedIngredients: null,
    usedIngredients: null,
    unusedIngredients: null,
  );

  group('test recipe model', () {
    test('should be a subclass of Recipe entity', () async {
      //assert
      expect(testRecipeModel, isA<RecipeEntity>());
    });

    test('should return a valid model from json', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_recipe_response.json'));

      //act
      final result = RecipeModel.fromJson(jsonMap);

      //assert
      expect(result, equals(testRecipeModel));
    });
  });
}
