import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/service/ad_service.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'bodytext_widget.dart';
import 'feedtitle_widget.dart';
import 'feedview_mode.dart';
import 'likecount_widget.dart';
import 'writerprofile_widget.dart';

class NewsFeedBody extends StatefulWidget {
  FeedArticle feedArticle;

  NewsFeedBody(this.feedArticle, {Key? key}) : super(key: key);

  @override
  _NewsFeedBodyState createState() => _NewsFeedBodyState();
}

class _NewsFeedBodyState extends State<NewsFeedBody> {
  late List<BannerAd> bannerAds;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adService = Provider.of<AdService>(context);

    bannerAds = [];

    adService.initialization.then((status) {
      setState(() {
        bannerAds.add(new BannerAd(
            adUnitId: adService.bannerAdUnitId,
            size: AdSize.fullBanner,
            request: AdRequest(),
            listener: adService.banAdListener)
          ..load());
      });
    });
  }

  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();
    var futureWritter =
        DatabaseService().getCIUser(widget.feedArticle.writtenBy);

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      color: feedViewMode.isDarkMode ? Colors.black : kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<CIUser>(
                initialData: null,
                future: futureWritter,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  return FeedTitleWidget(widget.feedArticle, snapshot.data);
                }),
            BodyTextWidget(htmlBody: widget.feedArticle.body),
            LikeCountWidget(feedArticle: widget.feedArticle),

            FutureBuilder<CIUser>(
                future: futureWritter,
                initialData: null,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  return WriterProfileWidget(writter: snapshot.data);
              }),

              if (bannerAds[1] != null)
              Container(
                  alignment: Alignment.center,
                  width: bannerAds[1].size.width.toDouble(),
                  height: bannerAds[1].size.height.toDouble(),
                  child: AdWidget(ad: bannerAds[1]))
          ],
        ),
      ),
    );
  }
}
