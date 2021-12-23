import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/shared/screenapp_bar.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'profile_head.dart';
import 'profile_userform.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight, 
          child: Stack(
            children: [
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: SizeConfig.screenHeight * 0.17,
              ),
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScreenAppBar(),
                    Provider.of<ProfileHead>(context),
                    SizedBox(height: 14),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8), 
                      child: Provider.of<UserDetailsForm>(context)), 
                  ],
                ),
              ),
              ScreenAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
