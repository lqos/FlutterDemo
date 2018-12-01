//登录界面
import 'package:example01/bean/HttpResult.dart';
import 'package:example01/bean/User.dart';
import 'package:example01/bean/UserLoginBean.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/UserRedux.dart';
import 'package:example01/utils/PreferencesUtils.dart';
import 'package:example01/utils/RegUtils.dart';
import 'package:example01/utils/httpnet/Http.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/src/store.dart';

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
    return new StoreBuilder<GSYState>(builder: (context, store) {
      return new Scaffold(
        appBar: new AppBar(),
        body: new MaterialButton(
          onPressed: () {
            toLogin(store);
//            User user = User.getInstance();
//            user.nickName = "wolosfhsifs";
//
//            Navigator.pop(context);
          },
          child: new Text("点击登录"),
        ),
      );
    });
  }

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        centerTitle: true,
//        title: new Text("登录"),
//      ),
//      body: new Container(
//        padding: EdgeInsets.all(15),
//        child: new Center(
//          child: new Column(
//            children: <Widget>[
//              new TextField(
//                controller: phoneController,
//                keyboardType: TextInputType.phone,
//                textInputAction: TextInputAction.next,
//                decoration: InputDecoration(
//                  icon: new Icon(Icons.account_box),
//                  contentPadding: EdgeInsets.all(10.0),
//                  labelText: '请输入账号',
//                  helperText: '请输入手机号',
//                ),
//                maxLines: 1,
//                maxLength: 11,
//              ),
//              new TextField(
//                controller: passController,
//                decoration: InputDecoration(
//                  icon: new Icon(Icons.vpn_key),
//                  contentPadding: EdgeInsets.all(10.0),
//                  labelText: '密码',
//                  helperText: '请输入密码',
//                ),
//                maxLines: 1,
//                maxLength: 18,
//                textInputAction: TextInputAction.done,
//                onSubmitted: (String value) {
//                  toLogin();
//                },
//                obscureText: true,
//              ),
//              new MaterialButton(
//                onPressed: toLogin,
//                minWidth: MediaQuery.of(context).size.width * 0.7,
//                child: new Text("登录",
//                    style: new TextStyle(color: Colors.white, fontSize: 16)),
//                color: Theme.of(context).primaryColor,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  toLogin(Store<GSYState> store) {
    //账号
//    String account = phoneController.text.toString();
//    if (!isInvalidMobile(account)) {
//      return;
//    }
////    //密码
//    String password = passController.text.toString();
//    if (!isInvalidPassword(password)) {
//      return;
//    }
    var data = {"accountName": "18232077504", "password": "123456"};
    Future future = Http.getInstance().postJson(HttpContans.login, data);
    future.then((bean) {
      var s = bean.data;
      Map<String, Object> map = new Map();
      s.forEach((k, v) {
        map[k] = v;
      });
      UserLoginBean userLoginBean = UserLoginBean.formJson(map);
      if (userLoginBean.code == 1000) {
        PreferencesUtils.putString("loginBeaninfo", s.toString());
        PreferencesUtils.putString("token", userLoginBean.token);
        PreferencesUtils.putString("userId", userLoginBean.userId);
        Http.getInstance().addHeader("token", userLoginBean.token);
        Http.getInstance().addHeader("userId", userLoginBean.userId);
        getProfile(userLoginBean.userId, store);
      }
    });
  }

  getProfile(String userId, Store<GSYState> store) {
    Map<String, Object> map = new Map();
    map["userId"] = userId;
    Future future = Http.getInstance().get(HttpContans.profile, map);
    future.then((result) {
      Map<String, Object> maps = result.data;
      HttpResult data = HttpResult.formJson(maps, User.getInstance());
      if (data.code == 1000) {
        store.dispatch(new UpdateUserAction(data.data));
        print("获取用户信息成功");
        print(data.data.toString());
        PreferencesUtils.putString("userInfo", data.data.toString());
        Navigator.of(context).pop();
      }
    });
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
    return true;
  }
}
