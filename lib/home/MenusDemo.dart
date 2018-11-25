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
        appBar: new AppBar(title: new Text('菜单演示'), actions: <Widget>[
          new PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  _bodyStr = value;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: '选项一的值', child: new Text('选项一')),
                    new PopupMenuItem<String>(
                        value: '选项二的值', child: new Text('选项二'))
                  ])
        ]),
        body: new Center(child: new Text(_bodyStr)));
  }
}
