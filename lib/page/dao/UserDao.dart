import 'dart:convert';

import 'package:dio/dio.dart';
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

  static toLogin(Store<GSYState> store) async {
    var data = {"accountName": "18232077504", "password": "123456"};
    Response res = await Http.getInstance().postJson(HttpContans.login, data);
    if (res != null && res.statusCode == 200 && res.data != null) {
      initHttp(res.data['token'], res.data['userId'].toString());
      PreferencesUtils.putString(Config.TOKEN, res.data['token']);
      PreferencesUtils.putString(Config.USER_ID, res.data['userId'].toString());
      User user = await getProfile(res.data['userId'].toString());
      PreferencesUtils.putString(Config.USER_INFO, json.encode(user.toJson()));
      store.dispatch(new UpdateUserAction(user));
      return true && user != null;
    } else {
      return false;
    }
  }

  static getProfile(String userId) async {
    Map<String, Object> map = new Map();
    map['userId'] = userId;
    Response res = await Http.getInstance().get(HttpContans.profile, map);
    if (res != null && res.data != null && res.statusCode == 200) {
      return User.fromJson(res.data['data']);
    } else {
      return null;
    }
  }

  static logout() {
    PreferencesUtils.remove(Config.TOKEN);
    PreferencesUtils.remove(Config.USER_ID);
    PreferencesUtils.remove(Config.USER_INFO);
    List<String> list = List();
    list.add('userId');
    list.add('token');
    Http.getInstance().remove(list);
  }
}
