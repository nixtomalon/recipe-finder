import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_finder/app/constants.dart';
import 'package:flutter/material.dart';

import '../../../../repositories/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  RecipeDetails({required this.recipe});

  Widget usedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 4,
            //offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: recipe.usedIngredients[index].image,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width / 5.2,
              height: MediaQuery.of(context).size.width / 5.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 80,
              width: 80,
              child: Image.asset('assets/images/loading.gif'),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(width: 16.0),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              '• ${recipe.usedIngredients[index].orignal}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget unusedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: recipe.unusedIngredients[index].image,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width / 5.2,
              height: MediaQuery.of(context).size.width / 5.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 80,
              width: 80,
              child: Image.asset('assets/images/loading.gif'),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(width: 16.0),
          Text(
            '• ${recipe.unusedIngredients[index].orignal}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget missedIngredients(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 4,
            //offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: recipe.missedIngredients[index].image,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width / 5.2,
              height: MediaQuery.of(context).size.width / 5.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 80,
              width: 80,
              child: Image.asset('assets/images/loading.gif'),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(width: 16.0),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              '• ${recipe.missedIngredients[index].orignal}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
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
                children: <Widget>[
                  Visibility(
                    visible: recipe.usedIngredients.length > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Used Ingredients',
                          style: kTextStyle.copyWith(
                              color: Colors.black, fontSize: 15.0),
                        ),
                        SizedBox(height: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: recipe.usedIngredients
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (MapEntry map) => usedIngredients(map.key),
                                )
                                .toList()),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: recipe.unusedIngredients.length > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unused Ingredients',
                          style: kTextStyle.copyWith(
                              color: Colors.black, fontSize: 15.0),
                        ),
                        SizedBox(height: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: recipe.unusedIngredients
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (MapEntry map) => missedIngredients(map.key),
                                )
                                .toList()),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: recipe.missedIngredients.length > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Missed Ingredients',
                          style: kTextStyle.copyWith(
                              color: Colors.black, fontSize: 15.0),
                        ),
                        SizedBox(height: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: recipe.missedIngredients
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (MapEntry map) => missedIngredients(map.key),
                                )
                                .toList()),
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
