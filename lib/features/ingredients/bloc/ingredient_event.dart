part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class AddIngredients extends IngredientEvent {
  final Ingredient ingredient;

  const AddIngredients({required this.ingredient});

  @override
  List<Object> get props => [ingredient];
}

class RemoveIngredients extends IngredientEvent {
  final int index;

  const RemoveIngredients({required this.index});

  @override
  List<Object> get props => [index];
}

class CountIngredients extends IngredientEvent {
  final List<Ingredient> ingredients;

  const CountIngredients({this.ingredients = const <Ingredient>[]});

  @override
  List<Object> get props => [ingredients];
}
