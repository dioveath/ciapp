import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

class ScreenAppBar extends StatelessWidget {
  const ScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 2.0,
              spreadRadius: 1.0),
        ],
      ),       
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: kBackgroundColor, size: 24)),
          SizedBox(width: 20),
          Text("Back",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: kBackgroundColor)),
        ],
      ),
    );
  }
}
