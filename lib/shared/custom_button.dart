import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final Color? color;
  final Color? textColor;
  final double? elevation;
  final void Function()? onTap;

  const CustomButton(
      {Key? key,
      required this.child,
      this.radius,
      this.onTap,
      this.color,
      this.textColor,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
      elevation: elevation ?? 2,
      color: color ?? kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 15.w))),
      child: InkWell(
          onTap: onTap ?? () {},
          splashFactory: InkRipple.splashFactory,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: SizedBox(width: double.infinity, height: 48.h, child: child)));
}
