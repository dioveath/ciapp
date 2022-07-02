import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/feedview_mode.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navbar_button.dart';

class LikeCountWidget extends StatefulWidget {
  FeedArticle feedArticle;

  LikeCountWidget({
    Key? key,
    required this.feedArticle,
  }) : super(key: key);

  @override
  _LikeCountWidgetState createState() => _LikeCountWidgetState();
}

class _LikeCountWidgetState extends State<LikeCountWidget> {
  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();
    var user = context.watch<User>();

    Map<dynamic, dynamic>? heartsBy = widget.feedArticle.heartsBy;
    if (heartsBy == null) heartsBy = {};
    bool hasLiked = heartsBy.containsKey(user.uid);
    int? likeCount = 0;
    if (hasLiked) likeCount = heartsBy[user.uid] > 5 ? 5 : heartsBy[user.uid];

    Color textColor = feedViewMode.isDarkMode ? kBackgroundColor : kTitleColor;

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
            top: BorderSide(
                color: feedViewMode.isDarkMode
                    ? Colors.white
                    : kSecondaryColor.withOpacity(0.3),
                width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          // Expanded(
          Container(
            width: 48.0 + likeCount! * 8.0,
            child: Stack(
              children: [
                ...List.generate(likeCount, (index) {
                  return Positioned(
                    left: 14.0 + index * 10.0,
                    top: 8.0 - index,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Icon(
                          index % 2 == 0
                              ? Icons.favorite_outline
                              : Icons.favorite,
                          color: feedViewMode.isDarkMode
                              ? Colors.white
                              : Colors.redAccent
                                  .withOpacity(1 - index / (likeCount! + 1)),
                          size: 24 - index * 2.0),
                    ),
                  );
                }),
                FutureBuilder<CIUser>(
                    future: DatabaseService()
                        .getCIUser(widget.feedArticle.writtenBy),
                    initialData: null,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container(child: CircularProgressIndicator());
                      var writter = snapshot.data;
                      return NavBarButton(
                          iconData: hasLiked
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: feedViewMode.isDarkMode
                              ? kBackgroundColor
                              : Colors.redAccent,
                          size: 24,
                          onTap: () {
                            setState(() {
                              if (writter!.doc_id != user.uid) {
                                if (!widget.feedArticle.heartsBy!
                                    .containsKey(user.uid))
                                  widget.feedArticle.heartsBy![user.uid] = 0;
                                widget.feedArticle.heartsBy![user.uid]++;

                                widget.feedArticle.likes =
                                    widget.feedArticle.likes! + 1;
                                DatabaseService()
                                    .updateArticle(widget.feedArticle);
                                writter.hearts = writter.hearts! + 1;
                                writter.exp_points = writter.exp_points! + 2;
                                debugPrint("hearts:  ${writter.hearts}");
                                debugPrint("exp_points: ${writter.exp_points}");
                                DatabaseService().updateCIUser(writter);
                              }
                            });
                          });
                    }),
              ],
            ),
          ),
          // ),
          Text("${widget.feedArticle.likes} hearts for this Article.",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: textColor,
                  )),
          Spacer(),
          NavBarButton(
            iconData: Icons.donut_large,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
