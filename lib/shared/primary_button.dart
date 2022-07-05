import 'package:ciapp/constants.dart';
import 'package:ciapp/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final double? radius;
  final Color? color;
  final Color? textColor;
  final double? elevation;
  final void Function()? onTap;

  const PrimaryButton(
      {Key? key,
      this.text,
      this.radius,
      this.onTap,
      this.color,
      this.textColor,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
      elevation: elevation ?? 1,
      color: color ?? kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 15.w))),
      child: InkWell(
          onTap: onTap ?? () {},
          splashFactory: InkRipple.splashFactory,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: SizedBox(
            width: double.infinity,
            height: 48.h,
            child: Center(
                child: CustomText(
              data: text ?? "Button",
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.white,
            )),
          )));
}
