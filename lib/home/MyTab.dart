import 'package:example01/common/CommontItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTab extends StatefulWidget {
  @override
  MyTabState createState() => new MyTabState();
}

class MyTabState extends State<MyTab> {
  String _bodyStr = '显示菜单的点击';

  TextStyle getLeftTextStyle() {
    return new TextStyle(fontSize: 15, color: Color(0xFF333333));
  }

  TextStyle getRightTextStyle() {
    return new TextStyle(fontSize: 13, color: Color(0xFF666666));
  }

  void onclickItem(String value) {
    setState(() {
      _bodyStr = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle leftTextStyle = this.getLeftTextStyle();
    TextStyle rightTextStyle = this.getRightTextStyle();
    final itemPressed = (String value) {
      onclickItem(value);
    };

    return new SingleChildScrollView(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Text(_bodyStr),
            new Container(
              height: 1,
              color: Color(0xFFeeeeee),
            ),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_account.png"),
              leftText: "我的钱包",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_mine_message.png"),
              leftText: "消息中心",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_collection.png"),
              leftText: "我的收藏",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_mine_faq.png"),
              leftText: "常见问题",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_mine_setting.png"),
              leftText: "设置",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new CommonItem(
              onPressed: (String value) {
                Navigator.of(context).pushNamed('Page1');
              },
              leftIcon: new AssetImage("images/ic_mine_setting.png"),
              leftText: "Demo",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
          ],
        ),
      ),
    );
  }
}
