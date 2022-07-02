import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';
import 'register_form.dart';

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),          
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  kSecondaryColor,
                  kTitleColor,
                ],
              ),
            ),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
