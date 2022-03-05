import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class DashboardScreen extends StatelessWidget {
  static String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
      appBar: AppBar(
        toolbarHeight: SizeConfig.screenHeight * 0.06, //54
        backgroundColor: kPrimaryDarkAccentColor,
        title: Text("CHARICHA INSTITUTE",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: kBackgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                  letterSpacing: 1.5,
                )),
        elevation: 0,
        leading: Container(
          // padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            clipBehavior: Clip.hardEdge,
            child: Image(
              image: AssetImage("assets/images/ci_logo_alpha.png"),
            ),
          ),
        ),
      ),
    );
  }
}
