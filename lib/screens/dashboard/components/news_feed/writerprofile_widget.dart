import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/screens/dashboard/components/news_feed/feedview_mode.dart';
import 'package:ciapp/screens/dashboard/components/profile/profileview_screen.dart';
import 'package:ciapp/screens/dashboard/components/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriterProfileWidget extends StatelessWidget {
  CIUser? writter;
  WriterProfileWidget({
    Key? key,
    this.writter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(
                  color: feedViewMode.isDarkMode
                      ? Colors.white
                      : kSecondaryColor.withOpacity(0.3),
                  width: 0.5)),
        ),
        child: Row(
          children: [
            ProfileCard(
              borderColor: CIUser.levelColor[writter!.level!-1],
              url: writter!.profile_URL,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileViewScreen(writter!.doc_id)));
              },
              width: writter!.level! + 1.0,
            ),
            SizedBox(width: 14),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: feedViewMode.isDarkMode
                              ? Colors.white
                              : kSecondaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(text: "WRITTEN BY\n"),
                        TextSpan(
                            text:
                                "${writter?.first_name} ${writter?.last_name}\n"),
                        TextSpan(
                            text: "${writter?.rank} of Charicha Institute\n"),
                      ]),
                )
              ],
            )),
          ],
        ));
  }
}
