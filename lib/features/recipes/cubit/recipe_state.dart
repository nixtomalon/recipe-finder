part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;

  RecipeLoaded({required this.recipes});
}

class RecipeError extends RecipeState {
  final String error;

  RecipeError({required this.error});
}
