import 'package:recipe_finder/features/recipes/domain/entities/ingredient_status.dart';

class IngredientStatusModel extends IngredientStatusEntity {
  const IngredientStatusModel({
    id,
    amount,
    unit,
    original,
    image,
  }) : super(
          id: id,
          amount: amount,
          unit: unit,
          image: image,
          original: original,
        );

  factory IngredientStatusModel.fromJson(Map<String, dynamic> map) {
    return IngredientStatusModel(
      id: map['id'] ?? '',
      amount: map['amount'] ?? 0.0,
      unit: map['unit'] ?? '',
      original: map['original'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
