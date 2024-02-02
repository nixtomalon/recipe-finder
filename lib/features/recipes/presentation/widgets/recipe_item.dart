import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

class RecipeItem extends StatelessWidget {
  final RecipeEntity recipe;
  const RecipeItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(recipe.image!),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.72),
              Colors.transparent,
            ],
            stops: [0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 12,
              bottom: 12,
              child: Text(
                recipe.title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    recipe.likes.toString(),
                    style: kTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 13.2,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 12,
                bottom: 12,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
