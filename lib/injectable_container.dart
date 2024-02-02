import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_finder/features/ingredients/data/data_scources/ingredient_api_service.dart';
import 'package:recipe_finder/features/ingredients/data/repositories/ingredient_repository_impl.dart';
import 'package:recipe_finder/features/ingredients/domain/repositories/ingredient_repository.dart';
import 'package:recipe_finder/features/ingredients/domain/usecases/search_ingredient.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_api_service.dart';
import 'package:recipe_finder/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/get_recipes.dart';
import 'package:recipe_finder/features/recipes/presentation/cubit/recipe_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<IngredientApiService>(IngredientApiService(sl()));

  sl.registerSingleton<IngredientRepository>(IngredientRepositoryImpl(sl()));

  sl.registerFactory<SearchIngredientBloc>(() => SearchIngredientBloc(sl()));

  sl.registerSingleton(SearchIngredientUseCase(sl()));

  sl.registerSingleton<RecipeApiService>(RecipeApiService(sl()));

  sl.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(sl()));

  sl.registerFactory<RecipeCubit>(() => RecipeCubit(sl()));

  sl.registerSingleton(GetRecipesUseCase(sl()));
}
