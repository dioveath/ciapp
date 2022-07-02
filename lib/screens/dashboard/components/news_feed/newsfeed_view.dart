import 'dart:async';

import 'package:ciapp/constants.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/service/ad_service.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'feedcard_widget.dart';

class NewsFeedView extends StatefulWidget {
  @override
  _NewsFeedViewState createState() => _NewsFeedViewState();
}

class _NewsFeedViewState extends State<NewsFeedView> {
  StreamController<FeedArticle>? _streamController;
  List<FeedArticle> feedArticles = [];

  late List<Object> itemList;

  initState() {
    super.initState();
  }

  void pipeArticles(StreamController<FeedArticle> _controller) {
    DatabaseService().streamArticles().pipe(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initList();
  }

  void initList() {
    _streamController?.close();
    _streamController = StreamController.broadcast();
    pipeArticles(_streamController!);
    final adService = Provider.of<AdService>(context);

    feedArticles.clear();
    itemList = List.from(feedArticles);

    _streamController!.stream.listen((article) => setState(() {
          itemList.add(article);

          adService.initialization.then((status) {
            if (itemList.length % 4 == 1) {
              itemList.insert(
                  itemList.length,
                  BannerAd(
                    adUnitId: adService.bannerAdUnitId,
                    size: AdSize.fullBanner,
                    request: AdRequest(),
                    listener: adService.banAdListener,
                  )..load());
            }
          });
        }));
  }

  dispose() {
    super.dispose();
    _streamController?.close();
    _streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: kDarkGradient,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: kSecondaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Row(
                  children: [
                    Text("News Feed",
                        style: Theme.of(context).textTheme.headline5),
                    Spacer(),
                    Icon(Icons.notifications,
                        color: kBackgroundColor, size: 28),
                    SizedBox(width: 5),
                    Icon(Icons.search_outlined,
                        color: kBackgroundColor, size: 28),
                    SizedBox(width: 5),
                    Icon(Icons.add_box_rounded,
                        color: kBackgroundColor, size: 28),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: RefreshIndicator(
                onRefresh: () {
                  setState(() {
                    initList();
                  });
                } as Future<void> Function(),
                child: Container(
                  child: ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        if (itemList[index] is FeedArticle) {
                          return FeedCardWidget(
                              feedArticle: itemList[index] as FeedArticle);
                        } else if (itemList[index] is BannerAd) {
                          return buildBannerAdContainer(
                              itemList[index] as BannerAd);
                        }

                        return Container(
                          alignment: Alignment.center,
                          height: 50,
                          color: Colors.red,
                        );
                      }),
                ),
              ),
            ),
            // ),
            Expanded(
              flex: 1,
              child: Container(
                color: kTitleColor,
              ),
            ),
          ],
        ));
  }

  Container buildBannerAdContainer(BannerAd ad) => Container(
      alignment: Alignment.center,
      width: ad.size.width.toDouble(),
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad));
}
