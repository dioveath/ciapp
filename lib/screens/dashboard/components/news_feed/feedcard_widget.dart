import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

import 'feedview_screen.dart';

class FeedCardWidget extends StatelessWidget {
  FeedArticle feedArticle;
  FeedCardWidget({
    Key? key,
    required this.feedArticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dom.Document doc = dom.Document.html(feedArticle.body!);

    String summary = "";
    List<dom.Element> elements = doc.children;
    for (int i = 0; i < elements.length; i++) {
      summary += elements[i].text;
      if (summary.length > 60)
        break;
    }
    summary = summary.trim();

    return MaterialButton(
      color: Colors.transparent,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FeedViewScreen(feedArticle)));
      },
      child: Container(
        height: SizeConfig.screenWidth! * 0.4, 
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(), 
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    child: Text(
                      feedArticle.title!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: kBackgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: summary,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                  Spacer(), 
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 10,
                            ),
                            SizedBox(width: 6),
                            Text("${feedArticle.likes} Likes",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline!
                                    .copyWith(color: kBackgroundColor)),
                          ],
                        ),
                        Row(
                          children: [
                            FutureBuilder<CIUser>(
                                future: DatabaseService()
                                    .getCIUser(feedArticle.writtenBy),
                                initialData: null,
                                builder: (context, snapshot) {
                                  var writter = snapshot.data;
                                  var writterName = "Mr.Nobody";
                                  if (writter != null)
                                    writterName =
                                        "${writter.first_name} ${writter.last_name}";
                                  return Text(writterName,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(
                                            color: kBackgroundColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ));
                                }),
                            Spacer(),
                            Text("${feedArticle.getReadTime()} Read",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline!
                                    .copyWith(
                                        color: kBackgroundColor, fontSize: 8)),
                            Spacer(flex: 2),
                          ],
                        ),
                        Text(
                            DateFormat('dd MMM yyyy')
                                .format(feedArticle.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(
                                    color: kBackgroundColor, fontSize: 8)),
                      ],
                    ),
                  ),
                  Spacer(), 
                ],
              ),
            ),
            // Spacer(),
            Image(
              width: getPWidth(256),
              height: getPHeight(256),
              image: NetworkImage(feedArticle.imageURL!),
            ),
          ],
        ),
      ),
    );
  }
}
