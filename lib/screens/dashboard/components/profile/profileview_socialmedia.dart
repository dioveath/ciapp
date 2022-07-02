import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileViewSocialMedia extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.8, 
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialMediaLinkCard(
            url: "",
            socialIcon: FontAwesomeIcons.facebookF,
          ),
          SocialMediaLinkCard(
            url: "",
            socialIcon: FontAwesomeIcons.instagram,
          ),
          SocialMediaLinkCard(
            url: "",
            socialIcon: FontAwesomeIcons.youtube, 
          ),
        ],
      ),
    );
  }
}

class SocialMediaLinkCard extends StatelessWidget {
  String? url;
  IconData? socialIcon;

  SocialMediaLinkCard({
    Key? key,
    this.url,
    this.socialIcon, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3000)),
        // side: BorderSide(width: 6.0, color: kPrimaryColor),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Container(
          // decoration: BoxDecoration(
          //   color: kBackgroundColor,
          //   // color: Colors.transparent,
          //   borderRadius: BorderRadius.circular(48),
          //   boxShadow: [
          //     BoxShadow(
          //         color: Colors.grey.withOpacity(0.3),
          //         blurRadius: 2.0,
          //         spreadRadius: 1.0),
          //   ],
          // ),
          color: Colors.transparent,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(0),
          child:
              Icon(socialIcon, size: 32, color: kPrimaryColor),
        ),
      ),
    );
  }
}
