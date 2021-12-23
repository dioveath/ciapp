import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ciapp/constants.dart';
import './components/body.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
