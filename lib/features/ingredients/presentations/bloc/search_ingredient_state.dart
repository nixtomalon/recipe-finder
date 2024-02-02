part of 'search_ingredient_bloc.dart';

abstract class SearchIngredientState extends Equatable {
  final List<IngredientEntity>? searchIngredients;
  final List<IngredientEntity>? pantry;
  final DioException? error;

  const SearchIngredientState({
    this.searchIngredients,
    this.pantry,
    this.error,
  });

  @override
  List<Object?> get props => [searchIngredients, pantry, error];
}

class SearchIngredientInitial extends SearchIngredientState {
  const SearchIngredientInitial();
}

class SearchIngredientLoading extends SearchIngredientState {
  const SearchIngredientLoading();
}

class SearchIngredientLoaded extends SearchIngredientState {
  const SearchIngredientLoaded(
      List<IngredientEntity>? ingredients, List<IngredientEntity>? pantry)
      : super(searchIngredients: ingredients, pantry: pantry);
}

class SearchIngredientError extends SearchIngredientState {
  const SearchIngredientError(DioException? error) : super(error: error);
}
