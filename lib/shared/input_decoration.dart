import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String text, IconData icon) {
  return InputDecoration(
    labelText: text,
    labelStyle: TextStyle(color: kDullColor.withOpacity(0.6)),
    prefixIcon: Icon(icon, color: kPrimaryColor),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    errorStyle: TextStyle(fontSize: 0, height: 0,), 
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      width: 1.0,
      color: kPrimaryColor,
    ),
  );
}
