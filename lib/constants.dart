import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

  enabledBorder: UnderlineInputBorder(      
	    borderSide: BorderSide(color: kSecondary),   
	  ),
  focusedBorder: UnderlineInputBorder(      
	    borderSide: BorderSide(color: kSecondary),   
	  ),
  filled: true,
  fillColor: null,
  prefixIcon: Icon(Icons.search, color: kSecondary),
  hintText: 'Search ingredients',
);

const kTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontFamily: 'Nunitos',
  fontWeight: FontWeight.bold,
);

const kPrimary = Color(0xffFAF8F4);
const kSecondary = Color(0xff30768a);
