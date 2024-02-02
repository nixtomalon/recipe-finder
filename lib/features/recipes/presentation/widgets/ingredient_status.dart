import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/constant.dart';
import 'package:recipe_finder/features/recipes/domain/entities/ingredient_status.dart';

class IngredientStatus extends StatelessWidget {
  final String status;
  final List<IngredientStatusEntity> ingredients;

  const IngredientStatus({
    Key? key,
    required this.status,
    required this.ingredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          status,
          style: kTextStyle.copyWith(color: Colors.black, fontSize: 15.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ingredients
              .map(
                (ing) => Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: kGreyColor,
                        spreadRadius: 4,
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: ing.image!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: size.width / 5.2,
                          height: size.width / 5.2,
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
                          child: Image.asset(loadingGif),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(width: 16.0),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          '• ${ing.original}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }
}
