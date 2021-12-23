import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/screens/dashboard/components/profile/profile_screen.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_card.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ci_user = Provider.of<CIUser>(context);

    if (ci_user == null)
      return Container(
          alignment: Alignment.center, child: CircularProgressIndicator());

    var stream_user = DatabaseService().streamCIUser(ci_user.doc_id);

    Color levelColor = CIUser.levelColor[ci_user.level - 1];
    double expBarWidth = SizeConfig.screenWidth * 0.3;

    int userLevel = ci_user.level;

    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(CIUser.levelIcons[userLevel - 1],
                              color: levelColor, size: 18),
                          SizedBox(width: 4),
                          Text(
                              "${CIUser.levelNames[userLevel - 1]} - ${userLevel}",
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(width: getPWidth(30)),
                          Text("${ci_user.exp_points} XP",
                              style: Theme.of(context).textTheme.bodyText1),
                        ]),
                  ),
                  SizedBox(height: 2),
                  Stack(
                    children: [
                      Container(
                        width: expBarWidth,
                        height: 5,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(1),
                            border: Border.all(color: levelColor, width: 1.0),
                            color: kBackgroundColor),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: expBarWidth * ci_user.getCurrentLevelCompletionPercent(),
                            height: 5,
                            color: levelColor),
                      ),
                    ],
                  ),
                  Text(
                      "To ${CIUser.levelNames[userLevel]} - ${CIUser.levelPoints[userLevel - 1] - ci_user.exp_points} XP",
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
            Container(
                child: Row(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ci_user.first_name +
                        " " +
                        ci_user.last_name +
                        "\n" +
                        ci_user.rank,
                    style: Theme.of(context).textTheme.bodyText2,
                    textDirection: TextDirection.rtl,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(color: kBackgroundColor)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.favorite, size: 16, color: Colors.redAccent),
                        Text("${ci_user.hearts} Hearts",
                            style: TextStyle(
                                color: kBackgroundColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(color: kBackgroundColor)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.follow_the_signs,
                            size: 16, color: Colors.black26),
                        Text("${ci_user.profileVisits} Profile Visits",
                            style: TextStyle(
                                color: kBackgroundColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Container(
                child: ProfileCard(
                    borderColor: levelColor,
                    url: ci_user.profile_URL,
                    width: userLevel + 1.0,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<CIUser>.value(
                                    initialData: ci_user,
                                    value: stream_user,
                                    child: ProfileScreen(),
                                  )));
                    }),
              ),
              // MaterialButton(
              //   padding: EdgeInsets.all(0),
              //   onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => StreamProvider<CIUser>.value(
              //                     initialData: ci_user,
              //                     value: stream_user,
              //                     child: ProfileScreen(),
              //                   )));
              //       // Navigator.pushNamed(context, ProfileScreen.routeName);
              //     },
              //     child: ProfileCard(
              //         borderColor: kSecondaryColor, url: ci_user.profile_URL),
              //   ),
            ])),
          ]),
    );
  }
}
