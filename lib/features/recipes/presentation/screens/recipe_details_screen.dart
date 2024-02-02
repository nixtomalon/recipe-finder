import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/presentation/widgets/ingredient_status.dart';

class RecipeDetails extends StatelessWidget {
  final RecipeEntity recipe;

  RecipeDetails({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(recipe.image!), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.6),
                      Colors.black.withOpacity(.3),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('${recipe.likes} LIKES',
                                style: kTextStyle.copyWith(fontSize: 13.0)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        recipe.title!,
                        style: kTextStyle.copyWith(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(12),
                children: [
                  Visibility(
                    visible: recipe.usedIngredients!.length > 0,
                    child: IngredientStatus(
                      status: 'Used Ingredients',
                      ingredients: recipe.usedIngredients!,
                    ),
                  ),
                  Visibility(
                    visible: recipe.unusedIngredients!.length > 0,
                    child: IngredientStatus(
                      status: 'Unused Ingredients',
                      ingredients: recipe.unusedIngredients!,
                    ),
                  ),
                  Visibility(
                    visible: recipe.missedIngredients!.length > 0,
                    child: IngredientStatus(
                      status: 'Missed Ingredients',
                      ingredients: recipe.missedIngredients!,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
