import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'imageselector_dialog.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ciUser = context.watch<CIUser>();

    if (ciUser == null) ciUser = CIUser.DefaultUser;

    var roles = ciUser.roles.keys.toList().reversed.toList();

    Color levelColor = CIUser.levelColor[ciUser.level - 1];
    int userLevel = ciUser.level;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: BorderDirectional(
            bottom: BorderSide(color: kPrimaryColor, width: 1.0)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3000)),
                  side:
                      BorderSide(width: userLevel + 1.0, color: levelColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(3000)),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(ciUser.profile_URL),
                    width: SizeConfig.screenWidth * 0.38,
                    height: SizeConfig.screenWidth * 0.38,
                  ),
                ),
              ),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                      onTap: () async {
                        await showDialog(
                                context: context,
                                builder: (_) =>
                                    ImageSelectorDialog(uid: ciUser.doc_id))
                            .then((value) {
                          if (value == null) return;
                          DatabaseService()
                              .updateCIUser(ciUser..profile_URL = value);
                        });
                      },
                      child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: levelColor,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Icon(Icons.edit,
                              color: kBackgroundColor, size: 24))))
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              child: Column(
                children: [
                  Text(
                    "Since ${DateFormat('dd MMM yyyy').format(ciUser.joinedAt)}",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: levelColor,
                          fontSize: 11.0,
                        ),
                  ),
                  Text(
                    "${ciUser.first_name.toUpperCase()} ${ciUser.last_name.toUpperCase()}",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: levelColor,
                          fontSize: 18.0,
                          wordSpacing: 2.3,
                          letterSpacing: 1.1,
                        ),
                  ),
                  Text(
                    "${ciUser.rank} of Charicha Institute",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: levelColor,
                          fontSize: 14.0,
                        ),
                  ),
                ],
              )),
          Icon(CIUser.levelIcons[userLevel - 1],
              color: levelColor, size: 28),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "${CIUser.levelNames[userLevel - 1]} - $userLevel",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: levelColor,
                              fontSize: 14,
                            )),
                    // SizedBox(width: 30),
                    Spacer(),
                    Text("${ciUser.exp_points} XP",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: levelColor,
                              fontSize: 14,
                            )),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 5,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(1),
                          border: Border.all(color: levelColor, width: 1.0),
                          color: kBackgroundColor),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 200 * ciUser.getCurrentLevelCompletionPercent(),
                          height: 5,
                          color: levelColor),
                    ),
                  ],
                ),
                Text(
                    "To ${CIUser.levelNames[userLevel]} - ${CIUser.levelPoints[userLevel - 1] - ciUser.exp_points} XP",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: levelColor)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.redAccent, size: 18),
                    SizedBox(width: 4),
                    Text("${ciUser.hearts} Hearts",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.redAccent)),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Roles",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: levelColor,
                              )),
                      Row(children: [
                        ...List<Text>.generate(
                            roles.length,
                            (index) => Text(
                                "${roles[index][0].toUpperCase()}${roles[index].substring(1)}${index != roles.length - 1 ? ', ' : ''}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: levelColor))),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
