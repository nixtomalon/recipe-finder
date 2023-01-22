part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();

  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientLoading extends IngredientState {}

class IngredientLoaded extends IngredientState {
  final List<Ingredient> ingredients;
  final int ingredientCount;

  IngredientLoaded(
      {this.ingredients = const <Ingredient>[], this.ingredientCount = 0});

  @override
  List<Object> get props => [ingredients];
}
