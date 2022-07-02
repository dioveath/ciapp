import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feedview_mode.dart';

// Will implement and optimize later
class TopBarWidget extends StatelessWidget {
  // double topNavHeight

  @override
  Widget build(BuildContext context) {
    FeedViewMode feedViewMode = context.watch<FeedViewMode>();

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      height: feedViewMode.isReadMode ? 0 : 54,
      decoration: BoxDecoration(
        color: feedViewMode.isDarkMode ? Colors.black : kPrimaryColor,
        // boxShadow: [BoxShadow(color: kDullColor.withOpacity(0.4), offset: const Offset(0, 2), blurRadius: 3, spreadRadius: 0.005)],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: kBackgroundColor, size: 20),
          ),
          SizedBox(width: 14),
          Text("Back to Dashboard",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    color: kBackgroundColor,
                  )),
          Spacer(),
        ],
      ),
    );
  }
}
