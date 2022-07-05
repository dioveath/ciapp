import 'package:ci_ui/ci_ui.dart';
import 'package:ci_ui/shared/style.dart';
import 'package:ciapp/constants.dart';
import 'package:ciapp/shared/custom_text.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Image.asset("assets/images/ci_pc.png",
                        height: 278.h),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          data: "Login with your credentials!",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: kDisabledColor)),
                    LoginForm(),

                    TextLink(
                        text: "Forget your credentials?",
                        onTapFunction: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Not available right now!")));
                        }),
                    SizedBox(height: 50.h),
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
                    SizedBox(height: 50.h),
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
  final Function? onTapFunction;
  final Alignment alignment;

  const TextLink({
    Key? key,
    this.text = "textlink",
    this.onTapFunction,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: GestureDetector(
          onTap: onTapFunction as void Function()?,
          child: CustomText(
            data: text,
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
          ),
        ),
    );
  }
}
