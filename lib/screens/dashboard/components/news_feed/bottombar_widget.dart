import 'package:ciapp/constants.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/feedview_mode.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navbar_button.dart';

class BottomBarWidget extends StatefulWidget {
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {


  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();



    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      height: feedViewMode.isReadMode ? 0 : getPHeight(130),
      color: feedViewMode.isDarkMode ? Colors.black : kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      child: Row(
        children: [
          NavBarButton(
              iconData: Icons.system_update,
              color: kBackgroundColor,
              size: 24,
              onTap: () {}),
          SizedBox(width: 24),
          NavBarButton(
              iconData: Icons.share,
              color: kBackgroundColor,
              size: 24,
              onTap: () {}),
          SizedBox(width: 24),
          NavBarButton(
              iconData: Icons.bookmark,
              color: kBackgroundColor,
              size: 24,
              onTap: () {}),
          SizedBox(width: 24),
          Spacer(),
          NavBarButton(
              iconData: feedViewMode.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: kBackgroundColor,
              size: 24,
              onTap: () {
                setState(() {
                  feedViewMode.toggleDarkMode();
                });
              }),
        ],
      ),
    );
  }
}
