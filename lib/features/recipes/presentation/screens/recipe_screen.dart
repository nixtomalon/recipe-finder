import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/presentation/cubit/recipe_cubit.dart';
import 'package:recipe_finder/features/recipes/presentation/widgets/recipe_item.dart';

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
                  child: Text(state.error!.message!),
                );
              }
              if (state is RecipeLoaded) {
                return ListView.builder(
                  itemCount: state.recipes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/RecipeDetails',
                            arguments: state.recipes![index]);
                      },
                      child: RecipeItem(recipe: state.recipes![index]),
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
