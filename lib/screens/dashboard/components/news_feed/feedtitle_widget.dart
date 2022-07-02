import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'feedview_mode.dart';

class FeedTitleWidget extends StatelessWidget {
  FeedArticle feedArticle;
  CIUser? writter;

  FeedTitleWidget(
    this.feedArticle,
    this.writter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();

    debugPrint("feedtitle widget:  ");

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(
                            color: feedViewMode.isDarkMode
                                ? Colors.white
                                : kSecondaryColor.withOpacity(0.3),
                            width: 0.5)),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: feedArticle.title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 22,
                            fontFamily: "Georgia",
                            color: feedViewMode.isDarkMode
                                ? kBackgroundColor.withOpacity(0.8)
                                : kTitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                              writter != null
                                  ? "${writter!.first_name} ${writter!.last_name}"
                                  : "Mr. Nobody",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                      color: feedViewMode.isDarkMode
                                          ? kBackgroundColor.withOpacity(0.8)
                                          : kTitleColor,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Text("${feedArticle.getReadTime()} Read",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                      color: feedViewMode.isDarkMode
                                          ? kBackgroundColor.withOpacity(0.8)
                                          : kTitleColor)),
                        ],
                      ),
                      Text(
                          DateFormat('dd MMM yyyy')
                              .format(feedArticle.createdAt!),
                          style: Theme.of(context).textTheme.overline!.copyWith(
                              color: feedViewMode.isDarkMode
                                  ? kBackgroundColor.withOpacity(0.8)
                                  : kTitleColor)),
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
