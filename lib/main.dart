import 'package:example01/home/MenusDemo.dart';
import 'package:example01/home/demo/Demo.dart';
import 'package:example01/home/demo/Home.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(home: new Home(), routes: <String, WidgetBuilder>{

      'MenusDemo': (BuildContext context) => new MenusDemo(),
      'Demo': (BuildContext context) => new Demo(),
    }));
