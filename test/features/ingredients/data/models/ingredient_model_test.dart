import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/features/ingredients/data/models/ingredient.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testIngredientModel =
      IngredientModel(name: 'apple', image: 'apple.jpg');

  group('test ingredient model', () {
    test('should be a subclass of Ingredient entity', () async {
      //assert
      expect(testIngredientModel, isA<IngredientEntity>());
    });

    test('should return a valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_ingredient_response.json'));

      // act
      final result = IngredientModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testIngredientModel));
    });
  });
}
