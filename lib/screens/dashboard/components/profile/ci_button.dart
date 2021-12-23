import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

class CIButton extends StatelessWidget {
  String text;
  Function onTap;
  bool positiveButton;

  CIButton({
    Key key,
    this.text,
    this.onTap,
    this.positiveButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: (14), vertical: 14),
        decoration: BoxDecoration(
          color: positiveButton ? kPrimaryColor : kDullColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5.copyWith(
            color: positiveButton ? kBackgroundColor : kBackgroundColor, 
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
