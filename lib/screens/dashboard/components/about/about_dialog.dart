import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

class AboutUsDialog extends StatelessWidget {
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kSecondaryColor,
      child: SizedBox(
        width: SizeConfig.screenWidth! * 0.7,
        height: SizeConfig.screenWidth! * 0.9,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("CHARICHA INSTITUTE APP"),
              Text("version 0.1.2"),
              Container(
                  padding: EdgeInsets.all(0),
                  child: Image(
                      width: SizeConfig.screenWidth! * 0.3,
                      height: SizeConfig.screenWidth! * 0.3,
                      image: AssetImage("assets/images/ci_logo_alpha.png"))),
              Text(
                  "Charicha Institute helps interested students to learn and use their computer skills from basic course to advance course like programming in real world. Come join us and grow.",
                  style: TextStyle(fontWeight: FontWeight.normal)),
              // Spacer(),
              Text("Copyright (c) All Rights Reserved 2021",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }
}
