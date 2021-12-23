import 'package:ciapp/authentication_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ciapp/constants.dart';
import 'splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> pages = [
    {
      "text": "Welcome to our humble place!",
      "imageLoc": "assets/images/welcome1.jpg"
    },
    {"text": "Engage more with app!", "imageLoc": "assets/images/welcome2.png"},
    {
      "text": "Learn more with digitalization!",
      "imageLoc": "assets/images/welcome3.png"
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) => SplashContent(
                  text: pages[index]['text'],
                  imageLoc: pages[index]['imageLoc']),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      pages.length, (index) => BlueDot(index: index)),
                ),
                Spacer(flex: 3),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticationWrapper()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Text("Get Started!",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  AnimatedContainer BlueDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      height: 8,
      width: index == currentPage ? 30 : 8,
      decoration: BoxDecoration(
        color: index == currentPage ? kPrimaryColor : kDullColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
