import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '129cd4737a0b4ba0a99c909cbb78ad5b';
const String getIngredientUrl = 'https://api.spoonacular.com/food/ingredients/autocomplete';
const String getRecipesUrl = 'https://api.spoonacular.com/recipes/findByIngredients';

const Map <String, String> headers = {"Content-Type": "application/json"};

class RequestData {

  Future <dynamic> getIngredients (String qry) async {
    http.Response response = await http.get('$getIngredientUrl?apiKey=$apiKey&query=$qry&number=15', headers: headers);

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }

  Future <dynamic> getRecipes (List <String> ingredient) async{

    String ingredients='';

    for(String str in ingredient) {
      ingredients = ingredients + str + ',+';
    }

    http.Response response = await http.get('$getRecipesUrl?apiKey=$apiKey&ingredients=$ingredients&number=15', headers: headers);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }
}