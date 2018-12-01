import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenusDemo extends StatefulWidget {
  @override
  _MenusDemoState createState() => new _MenusDemoState();
}

class _MenusDemoState extends State<MenusDemo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final double devicePixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    print("devicePixelRatio = " + devicePixelRatio.toString());
    print(size.width * devicePixelRatio);
    print(size.height * devicePixelRatio);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("发现"),
          centerTitle: true,
        ),
        body: new Container(
          width: size.width,
          height: size.width * 17 / 25,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("images/ic_user_bg.webp"),
                fit: BoxFit.cover),
            //设置子控件背后的装饰
//              color: Colors.blue, //和Container下面的color会冲突 具体原因不详
//              border: new Border.all(
//                //添加边框
//                width: 10.0, //边框宽度
//                color: Colors.green, //边框颜色
//              ),
//              borderRadius: new BorderRadius.all(Radius.circular(20.0)), //设置圆角
//              boxShadow: <BoxShadow>[
//                //设置阴影
////          new BoxShadow(
////            color: Colors.black,
////            blurRadius: 20.0,
////          ),
//                new BoxShadow(
//                  color: Colors.red, //阴影颜色
//                  blurRadius: 20.0, //阴影大小
//                ),
//          new BoxShadow(
//            color: Colors.yellowAccent,
//            blurRadius: 20.0,
//          ),
//          new BoxShadow(
//            color: Colors.blue,
//            blurRadius: 30.0,
//          )
          ),
          child: new Text(
              "sdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjlsdfkjl"),
        ));
  }
}
