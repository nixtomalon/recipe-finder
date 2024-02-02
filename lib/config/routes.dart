import 'package:flutter/material.dart';
import 'package:recipe_finder/features/ingredients/presentations/screens/pantry_screen.dart';
import 'package:recipe_finder/features/ingredients/presentations/screens/search_ingredients.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/presentation/screens/recipe_details_screen.dart';
import 'package:recipe_finder/features/recipes/presentation/screens/recipe_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(IngredientScreen());

      case '/DishesScreen':
        return _materialRoute(DishesScreen());

      case '/RecipeDetails':
        return _materialRoute(
            RecipeDetails(recipe: settings.arguments as RecipeEntity));

      case '/SearchIngredient':
        return _materialRoute(SearchIngredients());

      default:
        return _materialRoute(IngredientScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
