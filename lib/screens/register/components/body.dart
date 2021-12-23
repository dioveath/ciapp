import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
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
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight - MediaQuery.of(context).padding.top,
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
          child: Column(
            children: [
              Image.asset("assets/images/ci_logo_black.png",
                  height: getPHeight(300)),
              Text(
                  "Let's us make learning more possible, \nmore digital, more engaging.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              Container(
                  width: getPWidth(1080),
                  child: Text("Fill your registration form !",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: kPrimaryColor))),
              SizedBox(height: 5),
              Expanded(flex: 9, child: RegisterForm()), 
              Expanded(flex: 2,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      }, 
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, size: 24, color: kPrimaryColor),
                          SizedBox(width: 10),
                          Text("Back to Login",
                            style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.normal)),
                      ]),
                    ), 
                  ],
                )
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
