import 'package:example01/common/utils/utils.dart';
import 'package:flutter/material.dart';

class Animation1 extends StatefulWidget {
  _AnimationApp createState() => new _AnimationApp();
}

class _AnimationApp extends State<Animation1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  /*初始化状态*/
  initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          LoggerUtils.p(animation.value);
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward(); //执行动画
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

//  Widget build(BuildContext context) {
//    return new GestureDetector(
//        onTap: () {
//          startAnimtaion();         //点击文本 重新执行动画
//        },
//
//        child: new Center(
//            child: new Text(
//              "Flutter Animation(一2)",
//              style: TextStyle(fontSize: 20 * controller.value),   //更改文本字体大小
//            )
//        ));
//  }

  startAnimtaion() {
    setState(() {
      controller.forward(from: 0.0);
    });
  }

  dispose() {
    //销毁控制器对象
    controller.dispose();
    super.dispose();
  }
}
