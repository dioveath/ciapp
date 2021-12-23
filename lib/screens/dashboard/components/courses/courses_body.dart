import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

class CoursesBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kPrimaryColor, 
        child: Column(
          children: [
            Container(
                color: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    Material(
                        color: kPrimaryColor,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                Icon(Icons.arrow_back, color: kBackgroundColor))),
                    SizedBox(width: 14),
                    Text("Back",
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        )),
                  ],
                )),
            SingleChildScrollView(
              child: Container(
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/courses.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
