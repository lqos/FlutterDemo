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
    double h = getSH(context);

    double ws = w / DW;
    double hs = h / DH;
    print(hs.toString() + "<->" + ws.toString());
    if (ws < hs) {
      print(value.toString() + "ws" + (value * hs).toString());
      return value * ws;
    } else {
      print(value.toString() + "hs" + (value * hs).toString());
      return value * hs;
    }
  }
}
