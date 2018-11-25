import 'package:example01/home/MenusDemo.dart';
import 'package:example01/home/Page1.dart';
import 'package:example01/home/demo/Demo.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(home: new MyApp(), routes: <String, WidgetBuilder>{
      '/a': (BuildContext context) => new Page1(title: 'page A'),
      'MenusDemo': (BuildContext context) => new MenusDemo(),
      'Demo': (BuildContext context) => new Demo(),
    }));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(
      color: Colors.amber[500],
      fontSize: 18,
    );
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/a');
                },
                fillColor: Color(0xffeeeeee),
                child: new Text("Page1"),
              ),
              new RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('MenusDemo');
                },
                fillColor: Color(0xffeeeeee),
                child: new Text("MenusDemo"),
              ),
              new RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('Demo');
                },
                fillColor: Color(0xffeeeeee),
                child: new Text("Demo"),
              ),
              new Container(
                  padding: const EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text("我的设计", style: textStyle),
                      new Text("我的设计", style: textStyle),
                      new Text("我的设6计", style: textStyle),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
