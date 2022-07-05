import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String text, IconData icon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.transparent,
    labelText: text,
    labelStyle: TextStyle(
      fontFamily: "Gotham",
      fontWeight: FontWeight.w300,
      color: kDisabledColor),
    prefixIcon: Icon(icon, color: kDisabledColor),
    enabledBorder: outlineInputBorder(),
    focusedBorder: focusedInputBorder(),
    errorStyle: TextStyle(
      fontSize: 0,
      height: 0,
    ),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      width: 0.7,
      color: kDisabledColor.withAlpha(100),
    ),
  );
}

OutlineInputBorder focusedInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      width: 1.0,
      color: kPrimaryColor,
    ),
  );
}
