import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final String? fontFamily;
  final double? fontSize;
  final double? fontHeight;
  final Color? color;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;

  const CustomText({
    Key? key,
    required this.data,
    this.color,
    this.fontSize,
    this.fontHeight,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.textDecoration,
    this.fontFamily,
    this.textOverflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data,
        textAlign: textAlign,
        overflow: textOverflow,
        style: TextStyle(
          height: fontHeight,
            fontFamily: fontFamily ?? "Gotham",
            color: color,
            decoration: textDecoration,
            fontSize: fontSize,
            fontWeight: fontWeight));
  }
}
