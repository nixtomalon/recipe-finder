import 'package:RecipeFinder/constants.dart';
import 'package:RecipeFinder/screens/recipe_screen.dart';
import 'package:RecipeFinder/screens/search_ingredients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RecipeFinder/models/ingredient_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Information"),
    content: Text("You dont have ingredients yet."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _IngredientScreenState extends State<IngredientScreen> {
  var _ingredientProvider;

  @override
  void initState() {
    _ingredientProvider = Provider.of<IngredientData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "MY INGREDIENT'S",
                          style: TextStyle(
                            fontFamily: 'Poppins-ExtraBold',
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: kSecondary,
                          ),
                        ),
                        Text('THIS IS GIT SAMPLE'),
                        Text(
                          '${Provider.of<IngredientData>(context).ingredientCount} Ingredients',
                          style: kTextStyle.copyWith(
                            color: kSecondary,
                            fontSize: 14.0,
                            //letterSpacing: .5,
                          ),
                        )
                      ],
                    ),
                    Material(
                      elevation: 2.0,
                      color: kSecondary,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: kSecondary,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 16.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchIngredients();
                            }));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 22.0,
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 2.0,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<IngredientData>(
                  builder: (context, ingredientData, child) {
                    if (ingredientData.ingredientCount < 1) {
                      return Center(
                        child: Image(
                          height: 180.0,
                          image: AssetImage('assets/images/emptybasket.png'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: ingredientData.ingredientCount,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              // margin: EdgeInsets.only(bottom: 12),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      height: 72.0,
                                      width: 85.0,
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: ingredientData
                                            .ingredients[index].image,
                                      ),
                                    ),
                                    SizedBox(width: 18.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      child: Text(
                                        ingredientData.ingredients[index].name
                                            .toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: kSecondary,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child: IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.red,
                                        size: 18.0,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${ingredientData.ingredients[index].name} removed')));
                                        Provider.of<IngredientData>(context,
                                                listen: false)
                                            .removeIngredient(ingredientData
                                                .ingredients[index].name);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_ingredientProvider.ingredientCount <= 0) {
                    showAlertDialog(context);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RecipeScreen();
                    }));
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      border: Border.all(
                        color: kSecondary,
                        width: 3,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'GET RECIPES',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: kSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: kSecondary,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
