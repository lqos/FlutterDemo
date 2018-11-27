import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenusDemo extends StatefulWidget {
  @override
  _MenusDemoState createState() => new _MenusDemoState();
}

class _MenusDemoState extends State<MenusDemo> {
  String _bodyStr = '显示菜单的点击';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("发现"),
          centerTitle: true,
        ),
        body: new Center(child: new Text(_bodyStr)));
  }
}
