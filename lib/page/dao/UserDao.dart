import 'dart:convert';

import 'package:example01/bean/HttpResult.dart';
import 'package:example01/bean/User.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/UserRedux.dart';
import 'package:example01/utils/PreferencesUtils.dart';
import 'package:example01/utils/httpnet/Http.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';
import 'package:redux/redux.dart';

class UserDao {
  ///初始化用户信息
  static initUserInfo(Store store) async {
    var token = await PreferencesUtils.getString(Config.TOKEN, "");
    User user = await getUserInfoLocal();
    if (user != null && token.isNotEmpty && user.id > 0) {
      store.dispatch(new UpdateUserAction(user));
      initHttp(token, user.id.toString());
      return user;
    } else {
      return null;
    }
  }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await PreferencesUtils.getString(Config.USER_INFO, null);
    if (userText != null) {
      var userMap = json.decode(userText);
      return User.fromJson(userMap);
    } else {
      return null;
    }
  }

  ///初始化网络请求头
  static initHttp(String token, String id) {
    Http.getInstance().addHeader("token", token);
    Http.getInstance().addHeader("userId", id);
  }

  static void toLogin(Store<GSYState> store) async {
    var data = {"accountName": "18232077504", "password": "123456"};
    var res = await Http.getInstance().postJson(HttpContans.login, data);
    if (res != null) {
      print(res.toString());
    }

//      future.then((bean) {
//      var s = bean.data;
//      Map<String, Object> map = new Map();
//      s.forEach((k, v) {
//        map[k] = v;
//      });
//      UserLoginBean userLoginBean = UserLoginBean.formJson(map);
//      if (userLoginBean.code == 1000) {
//        PreferencesUtils.putString("loginBeaninfo", s.toString());
//        PreferencesUtils.putString("token", userLoginBean.token);
//        PreferencesUtils.putString("userId", userLoginBean.userId);
//        Http.getInstance().addHeader("token", userLoginBean.token);
//        Http.getInstance().addHeader("userId", userLoginBean.userId);
//        getProfile(userLoginBean.userId);
//
//        store.dispatch(new UpdateUserAction(data.data));
//      }
//    });
  }

  static getProfile(String userId) {
    Map<String, Object> map = new Map();
    map["userId"] = userId;
    Future future = Http.getInstance().get(HttpContans.profile, map);
    future.then((result) {
      Map<String, Object> maps = result.data;
      HttpResult data = HttpResult.formJson(maps);
      if (data.code == 1000) {
        print("获取用户信息成功");
        print(data.data.toString());
        PreferencesUtils.putString("userInfo", data.data.toString());
//        Navigator.of(context).pop();
      }
    });
  }
}
