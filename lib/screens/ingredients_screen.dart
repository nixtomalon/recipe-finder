import 'package:RecipeFinder/screens/add_ingredients.dart';
import 'package:RecipeFinder/constants.dart';
import 'package:RecipeFinder/screens/recipes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RecipeFinder/models/ingredientData.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'INGREDIENTBLE',
                          style: TextStyle(
                            fontFamily: 'Hammersmith One',
                            //fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: kSecondary,
                          ),
                        ),
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
                      elevation: 8.0,
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: AddIngredientsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Consumer<IngredientData>(
                  builder: (context, ingredientData, child) {
                    if (ingredientData.ingredientCount <= 0) {
                      return Center(
                        child: Image(
                          height: 180.0,
                          image: AssetImage('images/emptybasket.png'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: ingredientData.ingredientCount,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 12.0,right: 12.0, bottom: 6),
                            //color: Colors.blue,
                            child: Material(
                              elevation: 5.0,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 8.0),
                                        height: 65.0,
                                        width: 85.0,
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'images/loading.gif',
                                          image: ingredientData
                                              .ingredients[index].image,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Container(
                                        width: 150.0,
                                        child: Text(
                                          ingredientData
                                              .ingredients[index].name
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ),
                                    ]),
                                    IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.red,
                                        size: 18.0,
                                      ),
                                      onPressed: () {
                                        Provider.of<IngredientData>(context,
                                                listen: false)
                                            .removeIngredient(ingredientData
                                                .ingredients[index].name);
                                        print(Provider.of<IngredientData>(
                                                context,
                                                listen: false)
                                            .ingredientCount);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
                child: Material(
                  elevation: 5.0,
                  color: kSecondary,
                  borderRadius: BorderRadius.circular(30.0),
                  child: GestureDetector(
                    onTap: () {
                      if (Provider.of<IngredientData>(context, listen: false)
                              .ingredientCount <=
                          0) {
                        showAlertDialog(context);
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RecipeScreen();
                        }));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kSecondary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8.0),
                            child: Text(
                              'Get recipes',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
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
