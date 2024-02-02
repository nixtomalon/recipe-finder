import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<DataState<List<RecipeEntity>>> getRecipes(List<String> ingredients);
}
