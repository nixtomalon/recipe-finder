import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kSecondary),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kSecondary),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  filled: true,
  fillColor: Colors.white,
  //suffixIcon: Icon(Icons.search, color: kSecondary),
  hintText: 'Enter Ingredients',
);

const kTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontFamily: 'Poppins-Regular',
  fontWeight: FontWeight.bold,
);

const kPrimary = Color(0xffFAF8F4);
const kSecondary = Color(0xff30768a);

const kTextColor = Color(0xffc4c4c4);

// your api key (example)
const apiKey = "you api key";
