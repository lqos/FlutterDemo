import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  Navigator.of(context).pushNamed('Page1');
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
              new RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('Home');
                },
                fillColor: Color(0xffeeeeee),
                child: new Text("Home"),
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
