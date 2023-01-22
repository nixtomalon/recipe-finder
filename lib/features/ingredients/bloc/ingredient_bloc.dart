import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../repositories/models/ingredient.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  IngredientBloc() : super(IngredientLoaded()) {
    on<AddIngredients>(_onAddIngredient);
    on<RemoveIngredients>(_onRemoveIngredient);
  }

  void _onAddIngredient(AddIngredients event, emit) {
    final state = this.state;
    if (state is IngredientLoaded) {
      emit(IngredientLoaded(
        ingredients: List.from(state.ingredients)..add(event.ingredient),
        ingredientCount: state.ingredients.length + 1,
      ));
    }
  }

  void _onRemoveIngredient(RemoveIngredients event, emit) {
    final state = this.state;

    if (state is IngredientLoaded) {
      emit(IngredientLoaded(
        ingredients: List.from(state.ingredients)..removeAt(event.index),
        ingredientCount: state.ingredients.length - 1,
      ));
    }
  }
}
