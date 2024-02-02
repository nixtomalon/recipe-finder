import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/config/routes.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';
import 'package:recipe_finder/features/ingredients/presentations/screens/pantry_screen.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/features/recipes/presentation/cubit/recipe_cubit.dart';
import 'package:recipe_finder/injectable_container.dart';

void main() async {
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RecipeCubit(sl())),
        BlocProvider(create: (context) => SearchIngredientBloc(sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        title: 'Whats on your basket',
        home: IngredientScreen(),
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
        ),
      ),
    );
  }
}
