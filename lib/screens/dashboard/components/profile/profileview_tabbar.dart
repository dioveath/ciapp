import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:flutter/material.dart';

class ProfileViewTabBar extends StatefulWidget {
  CIUser ciUser;

  ProfileViewTabBar(this.ciUser);

  @override
  _ProfileViewTabBarState createState() => _ProfileViewTabBarState();
}

class _ProfileViewTabBarState extends State<ProfileViewTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(text: "Achievements"),
              Tab(text: "About Me"),
              Tab(text: "All Articles"),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AchievementCard(text: "Climbed up mountain!" ),
                        AchievementCard(text: "Played DOTA!"),
                        AchievementCard(text: "Killed 14 mosquitos in a night!"),
                      ],
                    )),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: kPrimaryAccentColor,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), 
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.headline5!.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.8, 
                                ), 
                                children: [
                                  TextSpan(
                                    text: "First Name: ${widget.ciUser.first_name} \n"),
                                  TextSpan(text: "Last Name: ${widget.ciUser.last_name} \n"), 
                                  TextSpan(text: "Address: ${widget.ciUser.address} \n"), 
                                  TextSpan(text: "Phone Number: ${widget.ciUser.phone_number} \n"), 
                                ], 
                              ),
                            ),
                          )
                        ], 
                      ), 
                    ), 
                Text("Published Articles"),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {

  String text; 

  AchievementCard({
      Key? key,
      this.text = "", 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
      decoration: BoxDecoration(
        color: kPrimaryAccentColor,
        
      ), 
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            Text(text,
              overflow: TextOverflow.ellipsis, 
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15, fontWeight: FontWeight.normal)),
            // Spacer(),
            Icon(Icons.stars, color: kBackgroundColor),
            // Spacer(),
          ]),
    );
  }
}
