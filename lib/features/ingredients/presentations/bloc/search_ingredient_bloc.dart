import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/domain/usecases/search_ingredient.dart';

part 'search_ingredient_event.dart';
part 'search_ingredient_state.dart';

class SearchIngredientBloc
    extends Bloc<SearchIngredientEvent, SearchIngredientState> {
  final SearchIngredientUseCase _searchIngredientUseCase;

  SearchIngredientBloc(this._searchIngredientUseCase)
      : super(const SearchIngredientInitial()) {
    on<SearchIngredient>(onSearchIngredient);
    on<AddToPantryIngredient>(onAddToPantryIngredient);
    on<RemoveIngredient>(onRemoveIngredient);
  }

  void onSearchIngredient(SearchIngredient event, emit) async {
    final pantry = state.pantry ?? [];
    emit(SearchIngredientLoading());
    final dataState = await _searchIngredientUseCase(params: event.query);

    if (dataState is DataSuccess) {
      emit(SearchIngredientLoaded(dataState.data!, pantry));
    }

    if (dataState is DataFailed) {
      emit(SearchIngredientError(dataState.error));
    }
  }

  void onAddToPantryIngredient(AddToPantryIngredient event, emit) {
    final List<IngredientEntity> pantry = List.from(state.pantry ?? [])
      ..add(event.ingredient!);

    final List<IngredientEntity> searchIngredients =
        state.searchIngredients != null
            ? List.from(state.searchIngredients!)
            : <IngredientEntity>[];

    searchIngredients.remove(event.ingredient);

    emit(SearchIngredientInitial());
    emit(SearchIngredientLoaded(searchIngredients, pantry));
  }

  void onRemoveIngredient(RemoveIngredient event, emit) {
    final List<IngredientEntity> newPantryList =
        state.pantry != null ? List.from(state.pantry!) : <IngredientEntity>[];

    newPantryList.remove(event.ingredient);

    final searchIngredients = state.searchIngredients ?? [];

    emit(SearchIngredientInitial());
    emit(SearchIngredientLoaded(searchIngredients, newPantryList));
  }
}
