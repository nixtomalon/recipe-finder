import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/repositories/api_repository.dart';
import 'package:recipe_finder/repositories/models/recipe.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit({required this.api}) : super(RecipeInitial());

  final FoodApiRepositoryImpl api;

  void getRecipes(List<String> query) async {
    emit(RecipeLoading());
    try {
      List<Recipe> recipes = [];
      recipes = await api.getRecipes(query);
      emit(RecipeLoaded(recipes: recipes));
    } catch (e) {
      emit(RecipeError(error: e.toString()));
    }
  }
}
