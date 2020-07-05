import 'dart:async';

import 'package:RecipeFinder/constants.dart';
import 'package:RecipeFinder/screens/recipesDetails_screen.dart';
import 'package:RecipeFinder/services/apiRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RecipeFinder/models/ingredientData.dart';

class RecipeScreen extends StatefulWidget {
  RecipeScreen({this.ingredients});

  final List<String> ingredients;

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  RequestData data = RequestData();
  var recipes;

  StreamController streamController;
  Stream stream;

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    stream = streamController.stream;
    updateUI();
  }

  void updateUI() async {
    streamController.add('Waiting');
    recipes = await data.getRecipes(
    Provider.of<IngredientData>(context, listen: false).ingredientName);
    streamController.add(recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kSecondary, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'AVAILABLE RECIPES',
          style: TextStyle(
              fontFamily: 'Hammersmith One',
              fontSize: 20.0,
              color: kSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        elevation: 0.0,
        backgroundColor: kPrimary,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('you dont have ingredients'),
                );
              }
              if (snapshot.data == 'Waiting') {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 200.0,
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data[index]['image']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.6),
                            Colors.black.withOpacity(.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 250.0,
                              child: Text(
                                snapshot.data[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            onPressed: () {
                              Provider.of<IngredientData>(context, listen: false).provideRecipeData(snapshot.data[index]);
                              //print(Provider.of<IngredientData>(context, listen: false).recipeData['image']);
                              Navigator.push(context, MaterialPageRoute(builder: (context){return RecipeDetails();}));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
