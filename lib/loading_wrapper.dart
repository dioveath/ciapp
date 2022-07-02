import 'package:after_layout/after_layout.dart';
import 'package:ciapp/authentication_wrapper.dart';
import 'package:ciapp/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class LoadingWrapper extends StatefulWidget {
  @override
  _LoadingWrapperState createState() => _LoadingWrapperState();
}

class _LoadingWrapperState extends State<LoadingWrapper>
    with AfterLayoutMixin<LoadingWrapper> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  Future checkFirstSeen(context) async {
    // Artificial wait for loading screen
    // await Future.delayed(Duration(seconds: 3));

    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? seen = pref.getBool("seen");

    if (seen == null) {
      pref.setBool("seen", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else if (seen == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen(context);
}
