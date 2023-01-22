// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/app/constants.dart';
import 'package:recipe_finder/features/ingredients/presentations/search_ingredients.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder/features/recipes/cubit/recipe_cubit.dart';

import '../../../repositories/models/ingredient.dart';
import '../../recipes/presentation/screens/recipe_screen.dart';
import '../bloc/ingredient_bloc.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
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
  int _ingredientCount = 0;
  List<Ingredient> ingreds = [];

  @override
  void initState() {
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
                          "My Basket",
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: kSecondary,
                          ),
                        ),
                        Text(
                          _ingredientCount < 1
                              ? 'Emypt Ingredient(s)'
                              : '$_ingredientCount Ingredient(s) available',
                          style: kTextStyle.copyWith(
                            color: Colors.black,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w400,
                            //letterSpacing: .5,
                          ),
                        ),
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
                child: BlocConsumer<IngredientBloc, IngredientState>(
                  listener: (context, state) {
                    if (state is IngredientLoaded) {
                      setState(() {
                        _ingredientCount = state.ingredientCount;
                        ingreds = state.ingredients;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (ingreds.length < 1) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Image(
                              height: 300.0,
                              image: AssetImage('assets/images/home.png'),
                            ),
                          ),
                          Positioned(
                            bottom: 232,
                            left: 12,
                            right: 12,
                            child: Text(
                              'Add all your available ingredient(s) to the basket so we can suggest a dishes and recipes.',
                              style: kTextStyle.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: ingreds.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Container(
                                    height: 72.0,
                                    width: 85.0,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loading.gif',
                                      image: ingreds[index].image!,
                                    ),
                                  ),
                                  SizedBox(width: 18.0),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    child: Text(
                                      ingreds[index].name!.toUpperCase(),
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
                                      setState(() {
                                        context.read<IngredientBloc>().add(
                                            RemoveIngredients(index: index));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                duration:
                                                    Duration(milliseconds: 900),
                                                content: Text(
                                                    '${ingreds[index].name} remove from your basket')));
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<RecipeCubit>()
                      .getRecipes(ingreds.map((e) => e.name!).toList());
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DishesScreen();
                  }));
                },
                child: Visibility(
                  visible: _ingredientCount > 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: kSecondary,
                      gradient: LinearGradient(
                        stops: [0.5, 1.0],
                        colors: [
                          kSecondary.withOpacity(.99),
                          kSecondary.withOpacity(.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'SUGGEST A DISHES',
                        style: kTextStyle.copyWith(
                          fontSize: 14.6,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
