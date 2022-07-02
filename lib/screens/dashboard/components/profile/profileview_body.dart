import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/shared/screenapp_bar.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

import 'profileview_bio.dart';
import 'profileview_head.dart';
import 'profileview_metrics.dart';
import 'profileview_socialmedia.dart';

class ProfileViewBody extends StatelessWidget {
  CIUser ciUser;
  bool dashboardView;
  ProfileViewBody(this.ciUser, {this.dashboardView = false});

  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: SizeConfig.screenHeight! - MediaQuery.of(context).padding.top,
        child: Stack(
          children: [
            Container(
              color: kPrimaryColor,
              width: double.infinity,
              height: SizeConfig.screenHeight! * 0.17,
            ),
            SizedBox(
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(!dashboardView) ScreenAppBar(),
                    ProfileViewHead(ciUser),
                    // Expanded(
                    //   child: ProfileViewTabBar(ciUser)
                    // ),
                    ProfileViewMetrics(ciUser),
                    if(!dashboardView)ProfileViewBio(),
                    if(!dashboardView)ProfileViewSocialMedia(),
                    // Expanded(child: ProfileViewDetails(ciUser)),
                  ],
                ),
              ),
            ),
            if(!dashboardView) ScreenAppBar(),
          ],
        ),
      ),
    );
  }
}
