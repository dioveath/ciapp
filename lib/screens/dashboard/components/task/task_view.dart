import 'package:ciapp/constants.dart';
import 'package:ciapp/models/task.dart';
import 'package:ciapp/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'taskview_screen.dart';
import 'taskview_widget.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  BannerAd bannerAd;

  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final adService = Provider.of<AdService>(context);
    adService.initialization.then((status) {
      setState(() {
        bannerAd = new BannerAd(
            adUnitId: adService.testBannerAdUnitId,
            size: AdSize.fullBanner,
            listener: adService.banAdListener,
            request: AdRequest())..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);

    if (tasks == null)
      return Container(
        color: kSecondaryColor,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );

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
              alignment: Alignment.center,
              child: Text("Your Tasks",
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          Expanded(
            flex: 7,
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: Container(
                child: tasks.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: Text("Add your first task!",
                            style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) =>
                            TaskWidget(task: tasks[index])),
              ),
            ),
          ),
          if (bannerAd != null)
            Container(
                alignment: Alignment.center,
                width: bannerAd.size.width.toDouble(),
                height: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd)), 

          Expanded(
            flex: 1,
            child: Container(
              color: kTitleColor,
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TaskViewScreen(Task(title: "", desc: ""))));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
