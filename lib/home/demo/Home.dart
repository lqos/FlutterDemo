import 'package:example01/home/MenusDemo.dart';
import 'package:example01/home/MyTab.dart';
import 'package:example01/home/demo/MyHomePage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int _tabIndex = 0;
  var _bodys = [new MyHomePage(), new MenusDemo(), new MyTab()];

  getIcon(int index) {
    if (index == 0) {
      return new Icon(Icons.home);
    } else if (index == 1) {
      return new Icon(Icons.nature);
    } else {
      return new Icon(Icons.face);
    }
  }

  getActiveIcon(int index) {
    if (index == 0) {
      return new Icon(Icons.home, color: Theme.of(context).accentColor);
    } else if (index == 1) {
      return new Icon(Icons.nature, color: Theme.of(context).accentColor);
    } else {
      return new Icon(Icons.face, color: Theme.of(context).accentColor);
    }
  }

  getTabText(int index) {
    if (index == 0) {
      return "首页";
    } else if (index == 1) {
      return "发现";
    } else {
      return "我的";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getIcon(0),
              activeIcon: getActiveIcon(0),
              title: new Text("首页")),
          new BottomNavigationBarItem(
              icon: getIcon(1),
              activeIcon: getActiveIcon(1),
              title: new Text("发现")),
          new BottomNavigationBarItem(
              icon: getIcon(2),
              activeIcon: getActiveIcon(2),
              title: new Text("我的")),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
