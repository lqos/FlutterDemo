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

class MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin<MyHomePage> {
  @override
  void initState() {
    super.initState();
    print("MyHomePageState initState");
  }

  @override
  void dispose() {
    super.dispose();
    print("MyHomePageState dispose");
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GSYState>(builder: (context, store) {
      User uer = store.state.userInfo;
      return Scaffold(
        appBar: AppBar(
          title: Text(uer.nickName ?? "w示"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("首页待开发"),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
