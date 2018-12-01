import 'package:example01/state/GSYState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppUtils {
  ///检查是否处于登录状态
  static bool checkLoin(context) {
    Store<GSYState> store = StoreProvider.of(context);
    if (store.state.userInfo == null) {
      return false;
    }
    return store.state.userInfo.id != null && store.state.userInfo.id > 0;
//    if (store.state.userInfo.id != null && store.state.userInfo.id < 0) {
//      return false;
//    }
//    return true;
  }
}
