import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/core/usecases/usecase.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipesUseCase
    implements UseCase<DataState<List<RecipeEntity>>, List<String>> {
  final RecipeRepository _recipeRepository;

  GetRecipesUseCase(this._recipeRepository);

  @override
  Future<DataState<List<RecipeEntity>>> call({List<String>? params}) {
    return _recipeRepository.getRecipes(params!);
  }
}
