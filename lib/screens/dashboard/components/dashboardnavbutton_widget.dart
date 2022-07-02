import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  Icon icon;
  String text;
  Function? onTap = () {};

  NavButton(
    this.icon,
    this.text, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryAltAccentColor,
      child: InkWell(
        onTap: onTap as void Function()?,
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(5.0),
          // clipBehavior: Clip.hardEdge, 
          child: Container(
            width: SizeConfig.screenWidth! / 3,
            decoration: BoxDecoration(
              border: Border.all(
                color: kBackgroundColor, width: 0.5, style: BorderStyle.solid),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(height: 6), 
                // Icon(FontAwesomeIcons.docker, size: 32, color: kBackgroundColor),
                Text(text,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 13,
                          color: kBackgroundColor,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.2, 
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
