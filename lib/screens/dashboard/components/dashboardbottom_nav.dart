import 'package:ciapp/constants.dart';
import 'package:ciapp/screens/dashboard/components/about/about_dialog.dart';
import 'package:ciapp/screens/dashboard/components/courses/courses_screen.dart';
import 'package:ciapp/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboardnavbutton_widget.dart';

class DashboardBottomNav extends StatelessWidget {
  PageController _controller;
  DashboardBottomNav(this._controller);

  Color iconColor = kBackgroundColor;

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                NavButton(
                    Icon(FontAwesomeIcons.home,
                        color: iconColor, size: 32),
                    "Home", onTap: () {
                  if (_controller.hasClients) {
                    _controller.animateToPage(0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  }
                }),
                NavButton(
                    Icon(FontAwesomeIcons.tasks, color: iconColor, size: 32),
                    "Tasks", onTap: () {
                  _controller.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }),
                NavButton(
                    Icon(FontAwesomeIcons.archive, color: iconColor, size: 32),
                    "Articles", onTap: () {
                  _controller.animateToPage(2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NavButton(
                    Icon(FontAwesomeIcons.graduationCap,
                        color: iconColor, size: 32),
                    "Courses", onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CoursesScreen()));
                }),
                NavButton(
                    Icon(FontAwesomeIcons.exclamationCircle,
                        color: iconColor, size: 32),
                    "About Us", onTap: () {
                  showDialog(
                      context: context, builder: (context) => AboutUsDialog());
                }),
                NavButton(
                    Icon(FontAwesomeIcons.signOutAlt,
                        color: iconColor, size: 32),
                    "Log out", onTap: () {
                  Provider.of<AuthenticationService>(context, listen: false)
                      .signOut();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
