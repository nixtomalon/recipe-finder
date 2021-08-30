import 'package:RecipeFinder/constants.dart';
import 'package:RecipeFinder/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  RecipeDetails({this.recipe});

  Widget usedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '- ${recipe.usedIngredients[index].originalString}',
        style: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget unusedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '- ${recipe.unusedIngredients[index].originalString}',
        style: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget missedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '- ${recipe.missedIngredients[index].originalString}',
        style: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(recipe.image), fit: BoxFit.cover),
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
                  children: <Widget>[
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                        recipe.title,
                        style: kTextStyle.copyWith(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              recipe.usedIngredients != null
                                  ? Text(
                                      '${recipe.usedIngredients.length} used ingredients',
                                      style: kTextStyle.copyWith(
                                          color: Colors.black, fontSize: 15.0),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 10.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recipe.usedIngredients
                                      .asMap()
                                      .entries
                                      .map<Widget>(
                                        (MapEntry map) =>
                                            usedIngredients(map.key),
                                      )
                                      .toList()),
                              SizedBox(height: 25.0),
                              recipe.unusedIngredients != null
                                  ? Text(
                                      '${recipe.unusedIngredients.length} unused ingredients',
                                      style: kTextStyle.copyWith(
                                          color: Colors.black, fontSize: 15.0),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 10.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recipe.unusedIngredients
                                      .asMap()
                                      .entries
                                      .map<Widget>(
                                        (MapEntry map) =>
                                            unusedIngredients(map.key),
                                      )
                                      .toList()),
                              SizedBox(height: 25.0),
                              recipe.missedIngredients != null
                                  ? Text(
                                      '${recipe.missedIngredients.length} missed ingredients',
                                      style: kTextStyle.copyWith(
                                          color: Colors.black, fontSize: 15.0),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 10.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recipe.missedIngredients
                                      .asMap()
                                      .entries
                                      .map<Widget>(
                                        (MapEntry map) =>
                                            missedIngredients(map.key),
                                      )
                                      .toList()),
                            ],
                          ),
                        ),
                      ],
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
