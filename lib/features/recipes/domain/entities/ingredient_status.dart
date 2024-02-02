import 'package:equatable/equatable.dart';

class IngredientStatusEntity extends Equatable {
  final int? id;
  final double? amount;
  final String? unit;
  final String? original;
  final String? image;

  const IngredientStatusEntity({
    this.id,
    this.amount,
    this.unit,
    this.original,
    this.image,
  });

  @override
  List<Object?> get props {
    return [id, amount, unit, original, image];
  }
}
