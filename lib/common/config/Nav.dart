import 'package:example01/page/demo/Home.dart';
import 'package:flutter/material.dart';

class Nav {
  static goHome(context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
}
