import 'package:example01/WelcomePage.dart';
import 'package:example01/data/User.dart';
import 'package:example01/page/Home.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/state/GSYStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

///程序入口
void main() => runApp(new FlutterReduxApp());

class FlutterReduxApp extends StatelessWidget {
  /// 创建Store，引用 GSYState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = new Store<GSYState>(
    appReducer,

    ///初始化数据
    initialState: new GSYState(
      userInfo: User.empty(),
      themeData: new ThemeData(
        primarySwatch: GSYColors.primarySwatch,
      ),
    ),
  );

  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<GSYState>(builder: (context, store) {
        return new MaterialApp(

          ///多语言实现代理
            localizationsDelegates: [
//              GlobalMaterialLocalizations.delegate,
//              GlobalWidgetsLocalizations.delegate,
//              GSYLocalizationsDelegate.delegate,
            ],
//            locale: store.state.locale,
//            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            home: new GSYLocalizations(
              child: new WelcomePage(),
            ),
            routes: {
              HomePage.sName: (context) {
                ///通过 Localizations.override 包裹一层，
                return new GSYLocalizations(
                  child: new HomePage(),
                );
              },
            });
      }),
    );
  }
}

class GSYLocalizations extends StatefulWidget {
  final Widget child;

  GSYLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<GSYLocalizations> createState() {
    return new _GSYLocalizations();
  }
}

class _GSYLocalizations extends State<GSYLocalizations> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
//        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
