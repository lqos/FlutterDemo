import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/common/utils/PreferencesUtils.dart';
import 'package:example01/common/utils/httpnet/Http.dart';
import 'package:example01/common/utils/httpnet/HttpContans.dart';
import 'package:example01/data//DataResult.dart';
import 'package:example01/data/User.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/UserRedux.dart';
import 'package:redux/redux.dart';

class UserDao {
  ///用户信息变更时保存
  static saveUserInfo(User user, Store store) {
    PreferencesUtils.putString(Config.USER_INFO, json.encode(user.toJson()));
    store.dispatch(new UpdateUserAction(user));
  }

  ///初始化用户信息
  static initUserInfo(Store store) async {
    var token = await PreferencesUtils.getString(Config.TOKEN, "");
    User user = await getUserInfoLocal();
    if (user != null && token.isNotEmpty && user.id > 0) {
      store.dispatch(new UpdateUserAction(user));
      initHttp(token, user.id.toString());
      getProfile(user.id.toString());
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

  static toLogin(Store<GSYState> store, Object data) async {
    Response res = await Http.getInstance().postJson(HttpContans.login, data);
    if (res != null && res.statusCode == 200 && res.data != null) {
      if (res.data['code'] == 1000) {
        initHttp(res.data['token'], res.data['userId'].toString());
        PreferencesUtils.putString(Config.TOKEN, res.data['token']);
        PreferencesUtils.putString(
            Config.USER_ID, res.data['userId'].toString());
        DataResult<User> dataResult =
        await getProfile(res.data['userId'].toString());
        if (dataResult.result) {
          saveUserInfo(dataResult.data, store);
        }
        return dataResult;
      }
      return DataResult.create<User>(false, message: res.data['message']);
    } else {
      return DataResult.create<User>(false, message: '未知错误');
    }
  }

  static getProfile(String userId) async {
    if (userId.isEmpty) {
      return DataResult.create<User>(false, message: '用户id为空');
    }
    Map<String, Object> map = new Map();
    map['userId'] = userId;
    Response res = await Http.getInstance().get(HttpContans.profile, map);
    if (res != null && res.data != null && res.statusCode == 200) {
      if (1000 == res.data['code']) {
        return DataResult.create<User>(true,
            data: User.fromJson(res.data['data']));
      } else {
        return DataResult.create<User>(false, message: res.data['message']);
      }
    } else {
      return DataResult.create<User>(false, message: '未知错误');
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
