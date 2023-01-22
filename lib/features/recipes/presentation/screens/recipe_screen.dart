import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/recipes/presentation/screens/recipe_details_screen.dart';

import '../../../../app/constants.dart';
import '../../../ingredients/cubit/search_ingredient_cubit.dart';
import '../../cubit/recipe_cubit.dart';

class DishesScreen extends StatelessWidget {
  const DishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondary),
        centerTitle: true,
        title: Text(
          'DISHES',
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
        padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: BlocConsumer<RecipeCubit, RecipeState>(
            listener: (context, state) {},
            builder: (BuildContext context, state) {
              if (state is RecipeLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RecipeError) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is RecipeLoaded) {
                return ListView.builder(
                  itemCount: state.recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return RecipeDetails(recipe: state.recipes[index]);
                        }));
                      },
                      child: Container(
                        height: 200.0,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: 10.0, left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(state.recipes[index].image!),
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
                                  state.recipes[index].title!,
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
                                      state.recipes[index].likes.toString(),
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
                      ),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}
