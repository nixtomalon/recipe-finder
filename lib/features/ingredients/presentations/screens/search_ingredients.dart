import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/ingredients/presentations/bloc/search_ingredient_bloc.dart';

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBgroundColor,
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
        backgroundColor: kBgroundColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _controller,
                      autofocus: true,
                      decoration: kTextFieldDecoration.copyWith(
                        fillColor: Colors.transparent,

                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _controller.text = ''),
                          icon: Icon(
                            Icons.close,
                            color: kSecondary,
                          ),
                        ),
                        //border: BorderRadius.all(radius)
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kSecondary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          BlocProvider.of<SearchIngredientBloc>(context)
                              .add(SearchIngredient(_controller.text));
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: BlocBuilder<SearchIngredientBloc, SearchIngredientState>(
                builder: (BuildContext context, state) {
                  if (state is SearchIngredientLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchIngredientLoaded) {
                    if (state.searchIngredients!.length < 1) {
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
                      itemCount: state.searchIngredients!.length,
                      itemBuilder: (_, int index) {
                        String? img = state.searchIngredients![index].image;
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      padding:
                                          EdgeInsets.only(top: 6, bottom: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: kGreyColor,
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            //offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(children: [
                                          CachedNetworkImage(
                                            width: size.width / 5.2,
                                            height: size.height / 12,
                                            imageUrl: '$imageUrl$img',
                                            imageBuilder: (_, image) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                //shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: image,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 80,
                                              width: 80,
                                              child: Image.asset(loadingGif),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          SizedBox(width: 16.0),
                                          Container(
                                            width: 150.0,
                                            child: Text(
                                              state.searchIngredients![index]
                                                  .name!
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16, height: 24)
                                ],
                              ),
                              Positioned(
                                right: 0,
                                top: 24,
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                '${state.searchIngredients![index].name} added')));
                                    BlocProvider.of<SearchIngredientBloc>(
                                        context)
                                      ..add(AddToPantryIngredient(
                                          state.searchIngredients![index]));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: kSecondary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                      child: Text(
                    'Enter some ingredientssss',
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
