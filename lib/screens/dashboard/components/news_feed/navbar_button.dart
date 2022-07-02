import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {
  Color color;
  double size;
  Function? onTap;
  IconData iconData;

  NavBarButton({
    Key? key,
    this.iconData = Icons.upgrade,
    this.color = kPrimaryColor,
    this.size = 24,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: onTap as void Function()?, child: Icon(iconData, color: color, size: size)),
    );
  }
}
