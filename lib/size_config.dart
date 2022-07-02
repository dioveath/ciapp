import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

}

  // Get Proportionate height at current context relative to 1080x1920
  double getPHeight(int height) {
    return height / 1920 * SizeConfig.screenHeight!;
  }

  double getPWidth(int width) {
    return width / 1080 * SizeConfig.screenWidth!;
  }

