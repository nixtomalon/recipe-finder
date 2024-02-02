import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';

class PantryItem extends StatelessWidget {
  final IngredientEntity? ingredient;

  const PantryItem({Key? key, this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: kGreyColor,
            spreadRadius: 4,
            blurRadius: 4,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: size.height / 10,
                  child: FadeInImage.assetNetwork(
                    placeholder: loadingGif,
                    image: '$imageUrl${ingredient!.image!}',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  ingredient!.name!.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kSecondary,
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 22.0,
                width: 22.0,
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red,
                    size: 18.0,
                  ),
                  onPressed: () {
                    BlocProvider.of<SearchIngredientBloc>(context)
                        .add(RemoveIngredient(ingredient!));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 900),
                        content: Text(
                            '${ingredient!.name} remove from your basket')));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
