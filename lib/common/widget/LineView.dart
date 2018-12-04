import 'package:flutter/material.dart';

/*
 * 一条直线
 */
// ignore: must_be_immutable
class LineView extends StatelessWidget {
  ///直线颜色
  Color color;

  ///直线厚度
  final double wide;

  ///直线长度
  final double length;

  ///直线方向
  final Orientation orientation;

  ///默认直线
  static final line = LineView(color: Color(0xFFdddddd));

  LineView(
      {this.wide = 0.5,
      this.color,
      this.length,
      this.orientation = Orientation.horizontal});

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      color = Color(0xFFDDDDDD);
    }
    if (orientation == Orientation.vertical) {
      return new Container(
        height: length,
        width: wide,
        color: color,
      );
    } else {
      return new Container(
        height: wide,
        width: length,
        color: color,
      );
    }
  }
}

enum Orientation {
  ///垂直方向
  vertical,

  ///水平方向
  horizontal
}
