import 'package:flutter/material.dart';

class DensityUtil {
  static const double DW = 360;
  static const double DH = 640;

  static getSW(context) {
    Size size = MediaQuery.of(context).size;
    return size.width;
  }

  static getSH(context) {
    Size size = MediaQuery.of(context).size;
    return size.height;
  }

  static getwx(context, double value) {
    double w = getSW(context);
    return value * DW / w;
  }

  static getwy(context, double value) {
    double w = getSH(context);
    return value * DH / w;
  }
}
