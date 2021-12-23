import 'package:ciapp/constants.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feedview_mode.dart';

class BodyImageWidget extends StatelessWidget {
  const BodyImageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();

    FeedArticle feedArticle = context.watch<FeedArticle>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              fit: BoxFit.contain,
              // height: getPHeight(600),
              image: NetworkImage(feedArticle.imageURL)),
          SizedBox(height: 6),
          Text("Image credit: ${feedArticle.imageURL.substring(0, 10)}",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: feedViewMode.isDarkMode
                      ? kBackgroundColor.withOpacity(0.8)
                      : kTitleColor)),
        ],
      ),
    );
  }
}
