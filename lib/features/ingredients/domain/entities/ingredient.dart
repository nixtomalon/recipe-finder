import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String? name;
  final String? image;

  const IngredientEntity({this.name, this.image});

  @override
  List<Object?> get props {
    return [name, image];
  }
}
