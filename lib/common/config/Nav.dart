import 'package:example01/page/UserInfoPage.dart';
import 'package:example01/page/demo/Home.dart';
import 'package:example01/page/home/MySetPage.dart';
import 'package:flutter/material.dart';

class Nav {
  ///主页
  static goHome(context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///我的设置
  static goAppSet(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new MySetPage()),
    );
  }

  ///用户信息
  static goUserInfoPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new UserInfoPage()),
    );
  }
}
