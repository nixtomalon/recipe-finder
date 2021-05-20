import 'dart:async';

import 'package:RecipeFinder/constants.dart';
import 'package:RecipeFinder/services/apiRequest.dart';
import 'package:flutter/material.dart';
import 'package:RecipeFinder/models/ingredientData.dart';
import 'package:provider/provider.dart';

class AddIngredientsScreen extends StatefulWidget {
  @override
  _AddIngredientsScreenState createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen> {
  RequestData data = RequestData();

  StreamController streamController;
  Stream stream;

  var _ingredients = [];
  var _controller = TextEditingController();

  void display(String str) async {
    if (str.isNotEmpty) {
      streamController.add('Waiting');
      _ingredients = await data.getIngredients(str);
      if (_ingredients != null) {
        streamController.add(_ingredients);
      }
    } else {
      streamController.add(null);
    }
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    stream = streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 500.0,
        decoration: BoxDecoration(
          color: Color(0xfff2f2ee),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'ADD INGREDIENTS',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff30768a),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    autofocus: true,
                    onChanged: (value) => display(value),
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: Colors.transparent,
                    )),
              ),
              SizedBox(height: 12.0),
              Expanded(
                child: StreamBuilder(
                  stream: stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: Text(
                        'Input Some Ingredients',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondary,
                        ),
                      ));
                    } else if (snapshot.data == 'Waiting') {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.data.length < 1) {
                      return Center(
                          child: Text(
                        'Ingredients Not Found',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondary,
                        ),
                      ));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        String img = snapshot.data[index]['image'];
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
                                  Container(
                                    height: 72.0,
                                    width: 88.0,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loading.gif',
                                      image:
                                          'https://spoonacular.com/cdn/ingredients_100x100/$img',
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Container(
                                    width: 150.0,
                                    child: Text(
                                      snapshot.data[index]['name']
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
                                              content: Text(
                                                  '${snapshot.data[index]['name']} removed')));
                                      Provider.of<IngredientData>(context,
                                              listen: false)
                                          .addIngredients(
                                              snapshot.data[index]['name'],
                                              'https://spoonacular.com/cdn/ingredients_100x100/$img');
                                      setState(
                                          () => snapshot.data.removeAt(index));
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
              //SizedBox(height: 10.0),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Material(
              //     elevation: 2.0,
              //     color: kSecondary,
              //     borderRadius: BorderRadius.circular(10.0),
              //     child: Container(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: <Widget>[
              //           Text(
              //             currName != ''
              //                 ? currName.toUpperCase() + ' ADDED'
              //                 : '',
              //             style: TextStyle(
              //               fontSize: 16.0,
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //               letterSpacing: .5,
              //             ),
              //           ),
              //           Icon(
              //             Icons.arrow_forward,
              //             color: Colors.white,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
