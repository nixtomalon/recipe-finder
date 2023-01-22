part of 'search_ingredient_cubit.dart';

abstract class SearchIngredientState extends Equatable {
  const SearchIngredientState();

  @override
  List<Object> get props => [];
}

class SearchIngredientInitial extends SearchIngredientState {}

class SearchIngredientLoading extends SearchIngredientState {}

class SearchIngredientLoaded extends SearchIngredientState {
  final List<Ingredient> ingredients;

  const SearchIngredientLoaded({required this.ingredients});
}

class SearchIngredientError extends SearchIngredientState {
  final String error;

  const SearchIngredientError({required this.error});
}

class GetRecipeLoading extends SearchIngredientState {}

class GetRecipeLoaded extends SearchIngredientState {
  final List<Recipe> recipes;

  GetRecipeLoaded({required this.recipes});
}

class GetRecipeError extends SearchIngredientState {
  final String error;

  GetRecipeError({required this.error});
}
