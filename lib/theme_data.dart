import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    fontFamily: 'GlacialIndifference',
    textTheme: TextTheme(
      headline5: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.normal),
      headline6: TextStyle(color: kPrimaryColor),
      bodyText1: TextStyle(color: Colors.white, fontSize: 13.0),
      bodyText2: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold), 
      button: TextStyle(fontSize: 18.0, color: Colors.white),
    ),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

InputDecorationTheme inputDecorationTheme() {

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kDullColor),
    gapPadding: 4,
  );  

  return InputDecorationTheme(
    // fillColor: kDullColor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(
        horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
