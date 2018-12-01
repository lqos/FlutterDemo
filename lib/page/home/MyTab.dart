import 'package:example01/bean/User.dart';
import 'package:example01/common/CommontItem.dart';
import 'package:example01/common/config/Nav.dart';
import 'package:example01/page/home/LoginPage.dart';
import 'package:example01/page/home/Page1.dart';
import 'package:example01/state/GSYState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyTab extends StatefulWidget {
  @override
  MyTabState createState() => new MyTabState();
}

class MyTabState extends State<MyTab> {
  TextStyle getLeftTextStyle() {
    return new TextStyle(fontSize: 18, color: Color(0xFF333333));
  }

  TextStyle getRightTextStyle() {
    return new TextStyle(fontSize: 13, color: Color(0xFF666666));
  }

  void onclickItem(int ids, String value) {
    switch (ids) {
      case 1001:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new Page1(title: "Navigator")),
        );
        break;
      case 1002:
        Nav.goAppSet(context);
        break;
      case 1003:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new LoginPage()),
        );
        break;
      default:
        break;
    }
    setState(() {
//      _bodyStr = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle leftTextStyle = this.getLeftTextStyle();
    TextStyle rightTextStyle = this.getRightTextStyle();
    final itemPressed = (int ids, String value) {
      onclickItem(ids, value);
    };
    Size size = MediaQuery
        .of(context)
        .size;
    final double devicePixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    print("devicePixelRatio = " + devicePixelRatio.toString());
    print(size.width * devicePixelRatio);
    print(size.height * devicePixelRatio);
    return new StoreBuilder<GSYState>(builder: (context, store) {
      User user = store.state.userInfo;
      return new Scaffold(
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                width: size.width,
                height: size.width * 17 / 25,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: new AssetImage("images/ic_user_bg.webp")),
                ),
                child: new Center(
                  child: new InkWell(
                      onTap: () {
                        onclickItem(1003, "去登陆");
                      },
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          user != null && user.id > 0
                              ? new Image.network(
                            user.portrait,
                            width: 50,
                            height: 50,
                          )
                              : new Icon(Icons.tag_faces),
                          new Text(
                            user == null
                                ? "user == null"
                                : (user.nickName == null
                                ? "点击请登录"
                                : user.nickName),
//                            user.nickName ?? "点击请登录",
                            maxLines: 1,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 18),
                          )
                        ],
                      )),
                ),
              ),
              new CommonItem(
                topLineHeight: 1,
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
                ids: 1002,
                onPressed: itemPressed,
                leftIcon: new AssetImage("images/ic_mine_setting.png"),
                leftText: "设置",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
              ),
              new CommonItem(
                ids: 1001,
                onPressed: itemPressed,
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
    });
  }
}
