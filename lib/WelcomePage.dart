import 'package:example01/common/config/Nav.dart';
import 'package:example01/page/dao/UserDao.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/GSYStyle.dart';
import 'package:example01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatefulWidget {
  static var sName = "welcome";

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  /*
  * 当插入渲染树的时候调用，这个函数在生命周期中只调用一次。这里可以做一些初始化工作，比如初始化State的变量。
  * */
  @override
  void initState() {
    super.initState();
    result = false;
  }

  ///避免多次进入
  bool result;

  /*这个函数会紧跟在initState之后调用，并且可以调用BuildContext.inheritFromWidgetOfExactType，
  那么BuildContext.inheritFromWidgetOfExactType的使用场景是什么呢？
  最经典的应用场景是*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (result) {
      return;
    }
    result = true;
    Store<GSYState> store = StoreProvider.of(context);
    UserDao.initUserInfo(store).then((user) {
      if (user == null) {
        LoggerUtils.p("初始化完成");
      } else {
        LoggerUtils.p("wei初始化完成");
      }
//      Navigator.of(context).pop();

    }).then((user) {

      Nav.goHome(context);
    });
  }

//当组件的状态改变的时候就会调用didUpdateWidget,比如调用了setState
  @override
  void didUpdateWidget(WelcomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

//一旦到这个阶段，组件就要被销毁了，这个函数一般会移除监听，清理环境。
  @override
  void dispose() {
    super.dispose();
  }

  //在dispose之前，会调用这个函数。
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return new Container(
          color: Color(GSYColors.white),
          child: new Center(
            child: new Text("欢迎使用"),
          ),
        );
      },
    );
  }
}
