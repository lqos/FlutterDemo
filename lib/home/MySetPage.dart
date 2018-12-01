import 'package:example01/bean/User.dart';
import 'package:example01/common/CommontItem.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/UserRedux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

//设置界面
class MySetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SetState();
  }
}

class SetState extends State<MySetPage> {
  TextStyle getLeftTextStyle() {
    return new TextStyle(fontSize: 18, color: Color(0xFF333333));
  }

  TextStyle getRightTextStyle() {
    return new TextStyle(fontSize: 13, color: Color(0xFF666666));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle leftTextStyle = this.getLeftTextStyle();
    TextStyle rightTextStyle = this.getRightTextStyle();
    return new StoreBuilder<GSYState>(builder: (context, store) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("设置"),
          centerTitle: true,
        ),
        body: new Container(
          padding: new EdgeInsets.all(0),
          child: new Column(
            children: <Widget>[
              new CommonItem(
                leftText: "关于我们",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
                topLineHeight: 1,
              ),
              new CommonItem(
                onPressed: (ids, value) {
                  User user = User.getInstance();
                  user.nickName = value;
                  store.dispatch(new UpdateUserAction(user));
                },
                leftText: "检查更新",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
              )
            ],
          ),
        ),
      );
    });
  }
}
