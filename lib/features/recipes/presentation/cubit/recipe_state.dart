part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  final List<RecipeEntity>? recipes;
  final DioException? error;

  const RecipeState({this.recipes, this.error});

  @override
  List<Object?> get props => [recipes, error];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  const RecipeLoaded(List<RecipeEntity>? recipes) : super(recipes: recipes);
}

class RecipeError extends RecipeState {
  const RecipeError(DioException? error) : super(error: error);
}
