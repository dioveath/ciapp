import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

import 'profileview_metricsside.dart';

class ProfileViewMetrics extends StatelessWidget {
  CIUser ciUser;

  ProfileViewMetrics(this.ciUser);

  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 2.0,
              spreadRadius: 1.0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ProfileMetricsSide(
                text: "${ciUser.hearts}",
                icon: Icon(Icons.favorite, color: Colors.redAccent)),
          ),
          buildBar(),
          Expanded(
            child: ProfileMetricsSide(
              text: "${ciUser.profileVisits}",
              icon: Icon(Icons.follow_the_signs, color: kPrimaryColor),
            ),
          ),
          buildBar(),
          Expanded(
            child: FutureBuilder<List<FeedArticle>>(
                future: DatabaseService().getAllUserFeedArticles(ciUser.doc_id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                  return Container(alignment: Alignment.center,
                    child: CircularProgressIndicator());
                  return ProfileMetricsSide(
                    text: "${snapshot.data.length}",
                    icon: Icon(Icons.article, color: kSecondaryColor),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Container buildBar() {
  return Container(
    height: 44,
    decoration: BoxDecoration(
      border: BorderDirectional(
          start: BorderSide(color: kPrimaryColor, width: 1.2)),
    ),
  );
}
