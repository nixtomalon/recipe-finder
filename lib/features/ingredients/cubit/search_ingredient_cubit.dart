import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../repositories/api_repository.dart';
import '../../../../repositories/models/ingredient.dart';
import '../../../../repositories/models/recipe.dart';
part 'search_ingredient_state.dart';

class SearchIngredientCubit extends Cubit<SearchIngredientState> {
  SearchIngredientCubit({required this.api}) : super(SearchIngredientInitial());

  final FoodApiRepositoryImpl api;

  Future<void> searchIngredient(String query) async {
    emit(SearchIngredientLoading());
    List<Ingredient> ingredients = [];
    try {
      ingredients = await api.searchIngredient(query);
      emit(SearchIngredientLoaded(ingredients: ingredients));
    } catch (e) {
      emit(SearchIngredientError(error: e.toString()));
    }
  }

  void removeFromList(List<Ingredient> ingredients, int index) {
    ingredients.removeAt(index);
    emit(SearchIngredientLoaded(ingredients: ingredients));
  }

  Future<void> getRecipes(List<String> query) async {
    emit(GetRecipeLoading());
    List<Recipe> recipes = [];
    try {
      recipes = await api.getRecipes(query);
      emit(GetRecipeLoaded(recipes: recipes));
    } catch (e) {
      emit(GetRecipeError(error: e.toString()));
    }
  }
}
