//登录界面
import 'package:example01/utils/RegUtils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  //输入手机号的控制器
  TextEditingController phoneController = TextEditingController();

//输入密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("登录"),
      ),
      body: new Container(
        padding: EdgeInsets.all(15),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: new Icon(Icons.account_box),
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '请输入账号',
                  helperText: '请输入手机号',
                ),
                maxLines: 1,
                maxLength: 11,
              ),
              new TextField(
                controller: passController,
                decoration: InputDecoration(
                  icon: new Icon(Icons.vpn_key),
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '密码',
                  helperText: '请输入密码',
                ),
                maxLines: 1,
                maxLength: 18,
                textInputAction: TextInputAction.done,
                onSubmitted: (String value) {
                  toLogin();
                },
                obscureText: true,
              ),
              new MaterialButton(
                onPressed: toLogin,
                minWidth: MediaQuery.of(context).size.width * 0.7,
                child: new Text("登录",
                    style: new TextStyle(color: Colors.white, fontSize: 16)),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  toLogin() {
    //账号
    String account = phoneController.text.toString();
    if (!isInvalidMobile(account)) {
      return;
    }
    //密码
    String password = passController.text.toString();
    if (!isInvalidPassword(password)) {
      return;
    }
  }

  showTipDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => showAlertDialog(message));
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

  //手机号是否无效
  isInvalidMobile(String account) {
    if (account.isEmpty) {
      showTipDialog("手机号不能为空");
      return false;
    }
    if (account.length < 11) {
      showTipDialog("手机号过短");
      return false;
    }
    if (!RegUtils.checkPhone(account)) {
      showTipDialog("手机号不合法");
      return false;
    }
    return true;
  }

  //密码是否无效
  isInvalidPassword(String password) {
    if (password.isEmpty) {
      showTipDialog("密码不能为空");
      return false;
    }
    if (password.length < 6) {
      showTipDialog("密码长度最少为6位");
      return false;
    }
  }
}
