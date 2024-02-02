import 'package:recipe_finder/features/recipes/data/models/ingredient_status.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    id,
    title,
    image,
    likes,
    missedIngredients,
    usedIngredients,
    unusedIngredients,
  }) : super(
          id: id,
          title: title,
          image: image,
          likes: likes,
          missedIngredients: missedIngredients,
          usedIngredients: usedIngredients,
          unusedIngredients: unusedIngredients,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      likes: map['likes'] ?? 0,
      missedIngredients: (map['missedIngredients'] as List<dynamic>?)
          ?.map((ing) => IngredientStatusModel.fromJson(ing))
          .toList(),
      usedIngredients: (map['usedIngredients'] as List<dynamic>?)
          ?.map((ing) => IngredientStatusModel.fromJson(ing))
          .toList(),
      unusedIngredients: (map['unusedIngredients'] as List<dynamic>?)
          ?.map((ing) => IngredientStatusModel.fromJson(ing))
          .toList(),
    );
  }
}
