import 'package:dio/dio.dart';
import 'package:example01/common/CommontItem.dart';
import 'package:example01/common/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DemoState();
  }
}

class DemoState extends State<Demo> {
  String _bodyStr = 'Demo样例';

  TextStyle getLeftTextStyle() {
    return new TextStyle(fontSize: 15, color: Color(0xFF333333));
  }

  TextStyle getRightTextStyle() {
    return new TextStyle(fontSize: 13, color: Color(0xFF666666));
  }

  void onclickItem(int ids, String value) {
    change(ids.toString() + value);
  }

  void change(String value) {
    setState(() {
      _bodyStr = value;
    });
  }

  AlertDialog showAlertDialog(String content) {
    return AlertDialog(
      title: Text("提示"),
      content: new Container(
        height: 30,
        child: new Column(
          children: <Widget>[
            new Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        new Container(
          child: new Padding(
              padding: EdgeInsets.all(10),
              child: new InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "确定",
                  style: new TextStyle(
                      fontSize: 15, color: Theme.of(context).accentColor),
                ),
              )),
        ),
      ],
    );
  }

//输入手机号的控制器
  TextEditingController phoneController = TextEditingController();

//输入姓名的控制器
  TextEditingController nameController = TextEditingController();

  getNameAndPhone() {
    String mobile = phoneController.text;
    String name = nameController.text;
    if (name == null || name.length == 0) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => showAlertDialog("姓名不能为空"));
      return;
    }
    if (mobile == null || mobile.length != 11) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => showAlertDialog("手机号码格式不对"));
      return;
    }
    phoneController.clear();
    nameController.clear();
    setState(() {
      _bodyStr = "姓名：" + name + "\n手机号码：" + mobile;
    });
  }

  get() async {
    Dio dio = new Dio();
    dio.get("http://www.baidu.com").then((obj) {
      LoggerUtils.p(obj.data);
    }, onError: (e) {
      LoggerUtils.p(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle leftTextStyle = this.getLeftTextStyle();
    TextStyle rightTextStyle = this.getRightTextStyle();
    final itemPressed = (int ids, String value) {
      onclickItem(ids, value);
    };

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Demo样例"),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Text(_bodyStr),
            new CommonItem(
              onPressed: itemPressed,
              leftIcon: new AssetImage("images/ic_account.png"),
              leftText: "我的钱包",
              leftTextStyle: leftTextStyle,
              rightTextStyle: rightTextStyle,
              rightText: "",
            ),
            new TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '(请输入你的姓名)',
                helperText: '请输入你的真实姓名',
              ),
              maxLines: 1,
              maxLength: 10,
              onChanged: change,
            ),
            new TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '(请输入你的手机号)',
              ),
              maxLines: 1,
              maxLength: 11,
              onChanged: change,
            ),
            new MaterialButton(
              onPressed: () {
                getNameAndPhone();
              },
              child: new Text("获取姓名和手机号"),
              color: Color(0xffe9e9e9),
            ),
            new MaterialButton(
              onPressed: () {
                get();
              },
              child: new Text("请求网络"),
              color: Color(0xffe9e9e9),
            )
          ],
        ),
      ),
    );
  }
}
