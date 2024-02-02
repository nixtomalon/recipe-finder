import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';

class IngredientModel extends IngredientEntity {
  const IngredientModel({required String name, required String image})
      : super(name: name, image: image);

  factory IngredientModel.fromJson(Map<String, dynamic> map) {
    return IngredientModel(name: map['name'] ?? '', image: map['image'] ?? '');
  }
}
