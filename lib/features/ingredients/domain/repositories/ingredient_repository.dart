import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';

abstract class IngredientRepository {
  Future<DataState<List<IngredientEntity>>> searchIngredient(String? query);
}
