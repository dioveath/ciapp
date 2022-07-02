import 'package:ci_ui/ci_ui.dart';
import 'package:ci_ui/shared/style.dart';
import 'package:ciapp/constants.dart';
import 'package:ciapp/shared/custom_text.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height:
                SizeConfig.screenHeight - MediaQuery.of(context).padding.top,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     kSecondaryColor,
                //     kTitleColor,
                //   ],
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Spacer(),
                    Image.asset("assets/images/ci_pc.png",
                        height: getPHeight(400)),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          data: "Let's us make learning more possible, \nmore digital, more engaging.",
                        ),
                      ),
                    Spacer(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Login with your credentials!",
                            style:
                                captionStyle.copyWith(color: kcPrimaryColor))),
                    SizedBox(height: 5),

                    LoginForm(),


                    SizedBox(height: 5),
                    TextLink(
                        text: "Forget your credentials?",
                        onTapFunction: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Not available right now!")));
                        }),
                    SizedBox(height: 10),
                    Spacer(),
                    TextLink(
                      text: "www.charichainstitute.com.np",
                      onTapFunction: () async {
                        const _url = "http://charichainstitute.com.np";
                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw "Couldn't lauch $_url";
                      },
                      alignment: Alignment.center,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextLink extends StatelessWidget {
  final String text;
  final Function onTapFunction;
  final Alignment alignment;

  const TextLink({
    Key key,
    this.text = "textlink",
    this.onTapFunction,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: GestureDetector(
          onTap: onTapFunction,
          child: Text(text,
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
              ))),
    );
  }
}
