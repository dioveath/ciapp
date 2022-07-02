import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/task.dart';
import 'package:ciapp/screens/dashboard/components/profile/profileview_body.dart';
import 'package:ciapp/screens/login/login_screen.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboardbottom_nav.dart';
import 'finance/finance_view.dart';
import 'news_feed/newsfeed_view.dart';
import 'profile_bar.dart';
import 'task/task_view.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentView = 0;
  PageController _controller = PageController();
  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if (user == null)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));

    var mainViews = [
      NewsFeedView(),
      FutureBuilder(
          future: dbService.getCIUser(user.uid),
          initialData: null,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());

            CIUser ciUser = snapshot.data as CIUser;
            if (ciUser.roles!.containsKey("ceo") ||
                ciUser.roles!.containsKey("cfo") ||
                ciUser.roles!.containsKey("manager")) {
              return FinanceView();
            } else
              return ProfileViewBody(ciUser, dashboardView: true);
          }),
      StreamProvider<List<Task>>.value(
        initialData: [],
        value: dbService.streamTask(user.uid),
        child: TaskView(),
      ),
    ];

    return SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! -
                    Scaffold.of(context).appBarMaxHeight!,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: StreamProvider<CIUser?>.value(
                          initialData: null,
                          value: dbService.streamCIUser(user.uid),
                          child: ProfileBar()),
                    ),
                    Expanded(
                      flex: 10,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ScrollConfiguration(
                            behavior: NoGlowScrollBehavior(),
                            child: PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    currentView = index;
                                  });
                                },
                                controller: _controller,
                                itemCount: mainViews.length,
                                itemBuilder: (context, index) {
                                  return mainViews[index];
                                }),
                          ),
                          Positioned(
                            bottom: getPHeight(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(mainViews.length, (index) {
                                return buildDot(index: index);
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: DashboardBottomNav(_controller),
                    ),
                  ],
                ))));
  }

  AnimatedContainer buildDot({int? index}) => AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        width: index == currentView ? 20 : 6,
        height: 6,
        decoration: BoxDecoration(
          color: index == currentView ? Colors.yellow : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      );
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
