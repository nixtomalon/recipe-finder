import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/ingredients/presentations/ingredients_screen.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/features/recipes/cubit/recipe_cubit.dart';

import 'features/ingredients/bloc/ingredient_bloc.dart';
import 'features/ingredients/cubit/search_ingredient_cubit.dart';
import 'repositories/api_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IngredientBloc()),
        BlocProvider(
            create: (context) =>
                SearchIngredientCubit(api: FoodApiRepositoryImpl())),
        BlocProvider(
            create: (context) => RecipeCubit(api: FoodApiRepositoryImpl()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whats on your basket',
        home: IngredientScreen(),
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
        ),
      ),
    );
  }
}
