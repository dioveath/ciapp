import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  Color? borderColor;
  String? url;
  double? width;
  Function? onTap = () {};

  ProfileCard({
    this.borderColor,
    this.width,
    this.url,
    this.onTap,
  });

  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3000)),
        side: BorderSide(width: width!, color: borderColor!),
      ),
      clipBehavior: Clip.hardEdge,
      // color: Colors.transparent,
      child: Ink.image(
        fit: BoxFit.cover,
        image: NetworkImage(url!),
        width: SizeConfig.screenWidth! * 0.2,
        height: SizeConfig.screenWidth! * 0.2,
        child: InkWell(
          onTap: onTap as void Function()?,
        ),
      ),
    );
  }
}
