import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchIngredientUseCase mockSearchIngredientUseCase;
  late SearchIngredientBloc searchIngredientBloc;

  setUp(() {
    mockSearchIngredientUseCase = MockSearchIngredientUseCase();
    searchIngredientBloc = SearchIngredientBloc(mockSearchIngredientUseCase);
  });

  group('test search ingredient bloc', () {
    final testIngredientEntity = IngredientEntity(
      name: 'apple',
      image: 'apple.jpg',
    );
    test('initial state should be empty', () async {
      expect(searchIngredientBloc.state, SearchIngredientInitial());
    });

    blocTest<SearchIngredientBloc, SearchIngredientState>(
      'emits [SearchIngredientLoading, SearchIngredientLoaded] when SearchIngredient event is added successfully',
      build: () {
        when(mockSearchIngredientUseCase(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess([testIngredientEntity]));
        return searchIngredientBloc;
      },
      act: (bloc) => bloc.add(SearchIngredient('query')),
      expect: () => [
        SearchIngredientLoading(),
        SearchIngredientLoaded([testIngredientEntity], []),
      ],
    );

    blocTest<SearchIngredientBloc, SearchIngredientState>(
      'emits [SearchIngredientLoading, SearchIngredientError] when SearchIngredient event fails',
      build: () {
        when(mockSearchIngredientUseCase(params: anyNamed('params')))
            .thenAnswer((_) async => DataFailed(MockDioException()));
        return searchIngredientBloc;
      },
      act: (bloc) => bloc.add(SearchIngredient('query')),
      expect: () => [
        SearchIngredientLoading(),
        isA<SearchIngredientError>(),
      ],
    );

    blocTest<SearchIngredientBloc, SearchIngredientState>(
      'emits [SearchIngredientInitial, SearchIngredientLoaded] when AddToPantryIngredient event is added',
      build: () => searchIngredientBloc,
      act: (bloc) => bloc.add(AddToPantryIngredient(testIngredientEntity)),
      expect: () => [
        SearchIngredientInitial(),
        SearchIngredientLoaded([], [testIngredientEntity]),
      ],
    );

    blocTest<SearchIngredientBloc, SearchIngredientState>(
      'emits [SearchIngredientInitial, SearchIngredientLoaded] when RemoveIngredient event is added',
      build: () => searchIngredientBloc,
      act: (bloc) => bloc.add(RemoveIngredient(testIngredientEntity)),
      expect: () => [
        SearchIngredientInitial(),
        SearchIngredientLoaded([], []),
      ],
    );
  });
}
