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

  var datas = [];
  var _controller = TextEditingController();
  String currName = '';

  void display(String str) async {
    streamController.add('Waiting');
    datas = await data.getIngredients(str);
    if (datas != null) {
      streamController.add(datas);
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
        decoration: BoxDecoration(
          color: Color(0xfff2f2ee),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        height: 500.0,
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
                      letterSpacing: .8,
                      fontFamily: 'Hammersmith One'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    autofocus: true,
                    onChanged: (value) {
                      display(value);
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      fillColor: Colors.transparent,
                    )),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: Text('Input some ingredients'));
                    } else if (snapshot.data == 'Waiting') {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          String img = snapshot.data[index]['image'];
                          return Container(
                            margin: EdgeInsets.only(
                                right: 5.0, left: 5.0, bottom: 5.0),
                            child: Material(
                              elevation: 3.0,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        height: 65.0,
                                        width: 85.0,
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'images/loading.gif',
                                          image:
                                              'https://spoonacular.com/cdn/ingredients_100x100/$img',
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
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
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: kSecondary,
                                        size: 20.0,
                                      ),
                                      onPressed: () {
                                        _controller.clear();
                                        Provider.of<IngredientData>(context,
                                                listen: false)
                                            .addIngredients(
                                                snapshot.data[index]['name'],
                                                'https://spoonacular.com/cdn/ingredients_100x100/$img');
                                        setState(() {
                                          currName = snapshot.data[index]['name'];
                                          snapshot.data.removeAt(index);
                                        });
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
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Material(
                    elevation: 5.0,
                    color: kSecondary,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(currName != '' ? currName.toUpperCase()+' ADDED' : '',
                            style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            letterSpacing: .5,
                            fontFamily: 'Nunito'),
                          ),
                          Icon(Icons.arrow_forward,color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
