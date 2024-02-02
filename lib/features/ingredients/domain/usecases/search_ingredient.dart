import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/core/usecases/usecase.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/domain/repositories/ingredient_repository.dart';

class SearchIngredientUseCase
    implements UseCase<DataState<List<IngredientEntity>>, String> {
  final IngredientRepository _ingredientRepository;

  SearchIngredientUseCase(this._ingredientRepository);

  @override
  Future<DataState<List<IngredientEntity>>> call({String? params}) {
    return _ingredientRepository.searchIngredient(params);
  }
}
