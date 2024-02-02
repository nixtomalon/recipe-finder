import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/ingredients/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder/features/ingredients/presentations/widgets/pantry_item.dart';
import 'package:recipe_finder/features/recipes/presentation/cubit/recipe_cubit.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Information"),
    content: Text("You dont have ingredients yet."),
    actions: [okButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _IngredientScreenState extends State<IngredientScreen> {
  int _ingredientCount = 0;
  List<IngredientEntity> _pantry = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight =
        (size.height - kToolbarHeight - (Platform.isAndroid ? 24 : 0)) / 4.4;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Pantry",
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
                            Navigator.pushNamed(context, '/SearchIngredient');
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
                child:
                    BlocConsumer<SearchIngredientBloc, SearchIngredientState>(
                  listener: (context, state) {
                    if (state is SearchIngredientLoaded) {
                      setState(() {
                        _ingredientCount = state.pantry!.length;
                        _pantry = state.pantry!;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state.pantry != null) {
                      if (state.pantry!.length < 1) {
                        return _emptyState(context);
                      }
                      return GridView.count(
                        padding: const EdgeInsets.all(16),
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: state.pantry!
                            .map((ing) => PantryItem(ingredient: ing))
                            .toList(),
                      );
                    }
                    return _emptyState(context);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<RecipeCubit>()
                      .getRecipes(_pantry.map((e) => e.name!).toList());

                  Navigator.pushNamed(context, '/DishesScreen');
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
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
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

  Stack _emptyState(BuildContext context) {
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
          bottom: MediaQuery.of(context).size.height / 5,
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
}
