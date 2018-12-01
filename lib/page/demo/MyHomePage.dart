import 'package:example01/bean/User.dart';
import 'package:example01/state/GSYState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  String _bodyStr = '显示菜单的点击';

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(builder: (context, store) {
      User uer = User.getInstance();
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(uer.nickName ?? "示"),
            centerTitle: true,
          ),
          body: new Center(child: new Text(uer.nickName ?? _bodyStr)));
    });
  }
}
