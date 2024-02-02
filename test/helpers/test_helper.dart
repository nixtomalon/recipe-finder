import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_finder/features/ingredients/data/data_scources/ingredient_api_service.dart';
import 'package:recipe_finder/features/ingredients/domain/repositories/ingredient_repository.dart';
import 'package:recipe_finder/features/ingredients/domain/usecases/search_ingredient.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_api_service.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/get_recipes.dart';

@GenerateMocks([
  IngredientRepository,
  RecipeRepository,
  SearchIngredientUseCase,
  GetRecipesUseCase,
])
@GenerateNiceMocks([
  MockSpec<Dio>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DioException>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<IngredientApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RecipeApiService>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
