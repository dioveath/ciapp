import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/bottombar_widget.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/newsfeed_body.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feedview_mode.dart';
import 'topbar_widget.dart';

class FeedViewScreen extends StatelessWidget {
  FeedArticle feedArticle;
  FeedViewScreen(this.feedArticle, {Key? key}) : super(key: key);
  FeedViewMode feedViewMode = new FeedViewMode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    debugPrint("feedview screen building");

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight! - MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              ChangeNotifierProvider<FeedViewMode>.value(
                value: feedViewMode,
                child: TopBarWidget(),
              ),
              Expanded(
                child: ChangeNotifierProvider<FeedViewMode>.value(
                  value: feedViewMode,
                  child: NewsFeedBody(feedArticle),
                ),
              ),
              ChangeNotifierProvider<FeedViewMode>.value(
                value: feedViewMode,
                child: BottomBarWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
