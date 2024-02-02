import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/features/recipes/data/models/ingredient_status.dart';
import 'package:recipe_finder/features/recipes/domain/entities/ingredient_status.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const ingredientStatusModel = IngredientStatusModel(
    id: 1,
    amount: 1.0,
    image: '',
    unit: '',
    original: '',
  );

  group('test ingredient status model', () {
    test('should be a subclass of IngredientStatus entity', () async {
      //assert
      expect(ingredientStatusModel, isA<IngredientStatusEntity>());
    });

    test('should return a valid model from json', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_ingredient_status_response.json'));

      //act
      final result = IngredientStatusModel.fromJson(jsonMap);

      //assert
      expect(result, equals(ingredientStatusModel));
    });
  });
}
