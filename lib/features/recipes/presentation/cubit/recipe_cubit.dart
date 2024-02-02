import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/get_recipes.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final GetRecipesUseCase _getRecipesUseCase;

  RecipeCubit(this._getRecipesUseCase) : super(RecipeInitial());

  void getRecipes(List<String> ingredients) async {
    emit(RecipeLoading());

    final dataState = await _getRecipesUseCase(params: ingredients);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RecipeLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RecipeError(dataState.error));
    }
  }
}
