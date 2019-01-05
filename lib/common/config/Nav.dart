import 'package:example01/page/Home.dart';
import 'package:example01/page/NewsDetailPage.dart';
import 'package:example01/page/UserInfoPage.dart';
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

  ///咨询详情页
  static goNewsDetailPage(context, String ids) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new NewsDetailPage(ids)),
    );
  }
}
