import 'package:ciapp/constants.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/feedview_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class BodyTextWidget extends StatelessWidget {
  String htmlBody;

  BodyTextWidget({
    Key key,
    this.htmlBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();

    Color textColor = feedViewMode.isDarkMode ? kBackgroundColor : kTitleColor;

    if (htmlBody == null)
      return Container(child: CircularProgressIndicator(backgroundColor: kPrimaryColor));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Html(
        data: htmlBody,
        style: {
          "p" : Style(
            fontWeight: FontWeight.normal,
            fontFamily: "Georgia",
            fontSize: FontSize(16),
            color: textColor, 
            lineHeight: LineHeight(1.4),
          ),
          "li" : Style(
            fontWeight: FontWeight.normal,
            fontFamily: "Georgia",
            fontSize: FontSize(14),
            color: textColor,
            lineHeight: LineHeight(1.4),
          ), 
        }, 
      ),
    );
  }
}
