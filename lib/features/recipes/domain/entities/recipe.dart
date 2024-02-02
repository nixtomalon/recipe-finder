import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipes/domain/entities/ingredient_status.dart';

class RecipeEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final int? likes;
  final List<IngredientStatusEntity>? missedIngredients;
  final List<IngredientStatusEntity>? usedIngredients;
  final List<IngredientStatusEntity>? unusedIngredients;

  const RecipeEntity({
    this.id,
    this.title,
    this.image,
    this.likes,
    this.missedIngredients,
    this.usedIngredients,
    this.unusedIngredients,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      image,
      likes,
      missedIngredients,
      usedIngredients,
      unusedIngredients,
    ];
  }
}
