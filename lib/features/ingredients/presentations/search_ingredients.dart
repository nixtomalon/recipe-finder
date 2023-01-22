import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/app/constants.dart';
import 'package:flutter/material.dart';
import '../../../repositories/models/ingredient.dart';
import '../bloc/ingredient_bloc.dart';
import '../cubit/search_ingredient_cubit.dart';

class SearchIngredients extends StatefulWidget {
  @override
  _SearchIngredientsState createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondary),
        centerTitle: true,
        title: Text(
          'Search',
          style: kTextStyle.copyWith(
            fontSize: 18.0,
            color: kSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: kPrimary,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                autofocus: true,
                onChanged: (value) {
                  BlocProvider.of<SearchIngredientCubit>(context)
                      .searchIngredient(value);
                },
                decoration: kTextFieldDecoration.copyWith(
                  fillColor: Colors.transparent,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _controller.text = ''),
                    icon: Icon(
                      Icons.close,
                      color: kSecondary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: BlocBuilder<SearchIngredientCubit, SearchIngredientState>(
                builder: (BuildContext context, state) {
                  if (state is SearchIngredientLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchIngredientLoaded) {
                    if (state.ingredients.length < 1) {
                      return Center(
                          child: Text(
                        'Ingredients not found',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondary,
                        ),
                      ));
                    }
                    return ListView.builder(
                      itemCount: state.ingredients.length,
                      itemBuilder: (BuildContext context, int index) {
                        String? img = state.ingredients[index].image;
                        return Container(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2.0,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://spoonacular.com/cdn/ingredients_100x100/$img',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width /
                                          5.2,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              5.2,
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
                                      child: Image.asset(
                                          'assets/images/loading.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(width: 16.0),
                                  Container(
                                    width: 150.0,
                                    child: Text(
                                      state.ingredients[index].name!
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito'),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 22.0,
                                  width: 22.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: kSecondary,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      _controller.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Text(
                                                  '${state.ingredients[index].name} added')));

                                      context.read<IngredientBloc>().add(
                                          AddIngredients(
                                              ingredient: Ingredient(
                                                  name: state
                                                      .ingredients[index].name,
                                                  image:
                                                      'https://spoonacular.com/cdn/ingredients_100x100/$img')));
                                      // _ingredientProvider.addIngredients(snapshot.data[index].name,
                                      //     'https://spoonacular.com/cdn/ingredients_100x100/$img');
                                      setState(() =>
                                          state.ingredients.removeAt(index));
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
                  return Center(
                      child: Text(
                    'Enter some ingredients',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: kSecondary,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
