import 'package:RecipeFinder/models/ingredientData.dart';
import 'package:RecipeFinder/screens/ingredients_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (context) => IngredientData(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whats on your fridge',
        home: IngredientScreen(),
      ),
    );
  }
}

