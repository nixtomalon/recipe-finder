part of 'search_ingredient_bloc.dart';

abstract class SearchIngredientEvent extends Equatable {
  final String? query;
  final IngredientEntity? ingredient;

  const SearchIngredientEvent({this.query, this.ingredient});

  @override
  List<Object> get props => [query!, ingredient!];
}

class SearchIngredient extends SearchIngredientEvent {
  const SearchIngredient(String? query) : super(query: query);
}

class AddToPantryIngredient extends SearchIngredientEvent {
  const AddToPantryIngredient(IngredientEntity ingredient)
      : super(ingredient: ingredient);
}

class RemoveIngredient extends SearchIngredientEvent {
  const RemoveIngredient(IngredientEntity ingredient)
      : super(ingredient: ingredient);
}
