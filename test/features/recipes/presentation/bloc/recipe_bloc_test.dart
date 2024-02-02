import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/core/resources/data_state.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/presentation/cubit/recipe_cubit.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetRecipesUseCase mockGetRecipesUseCase;
  late RecipeCubit recipeCubit;

  setUp(() {
    mockGetRecipesUseCase = MockGetRecipesUseCase();
    recipeCubit = RecipeCubit(mockGetRecipesUseCase);
  });

  group('test recipe cubit', () {
    test('initial state should empty', () {
      expect(recipeCubit.state, RecipeInitial());
    });

    blocTest<RecipeCubit, RecipeState>(
      'emits [RecipeLoading, RecipeLoaded] when GetRecipe method calls',
      build: () {
        when(mockGetRecipesUseCase(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess([RecipeEntity()]));
        return recipeCubit;
      },
      act: (cubit) => cubit.getRecipes(['apple']),
      expect: () => [
        RecipeLoading(),
        RecipeLoaded([RecipeEntity()])
      ],
    );
  });
}
