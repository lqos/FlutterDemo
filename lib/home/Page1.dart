import 'package:example01/common/CommontItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  final String title;

  const Page1({this.title});

  @override
  State<StatefulWidget> createState() {
    return new Page1State();
  }
}

class Page1State extends State<Page1> {
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
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
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Text(_bodyStr),
              new Container(
                height: 1,
                color: Color(0xFFeeeeee),
              ),
              new CommonItem(
                onPressed: (value) {
                  Navigator.of(context).pop();
                },
                leftIcon: new AssetImage("images/ic_mine_setting.png"),
                leftText: "返回",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
              ),
              new CommonItem(
                onPressed: (value) {
                  Navigator.of(context).pushNamed("Demo");
                },
                leftIcon: new AssetImage("images/ic_mine_setting.png"),
                leftText: "样例",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
              ),
              new CommonItem(
                onPressed: (String value) {
                  showBottomSheet<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return new Container(
                            height: 150,
                            child: new Center(
                                child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text('选择分享平台',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18.0)),
                                new Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      new ShareTextWithTopIcon(
                                          text: "QQ",
                                          textStyle: null,
                                          icon: new AssetImage(
                                              "images/ic_share_qq.png")),
                                      new ShareTextWithTopIcon(
                                          text: "微信",
                                          textStyle: null,
                                          icon: new AssetImage(
                                              "images/ic_share_wx.png"))
                                    ],
                                  ),
                                ),
                                new Text('取消',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18.0)),
                              ],
                            )));
                      });
                },
                leftIcon: new AssetImage("images/ic_mine_setting.png"),
                leftText: "分享底部弹框",
                leftTextStyle: leftTextStyle,
                rightTextStyle: rightTextStyle,
                rightText: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareTextWithTopIcon extends StatelessWidget {
  // ignore: must_be_immutable
  final String text;
  final TextStyle textStyle;
  final ImageProvider icon;

  const ShareTextWithTopIcon({this.text, this.textStyle, this.icon});

  @override
  Widget build(BuildContext context) {
    var lefticon;
    if (icon != null) {
      lefticon = new Image(image: icon, height: 45, width: 45);
    } else {
      IconData iconData = Icons.chevron_right;
      lefticon = new Icon(iconData, color: Color(0xff666666));
    }

    // TODO: implement build
    return new Container(
        child: new Column(
      children: <Widget>[
        lefticon,
        new Text(
          this.text,
          style: this.textStyle,
        ),
      ],
    ));
  }
}
