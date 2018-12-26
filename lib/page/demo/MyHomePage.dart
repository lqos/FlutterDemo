import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Color c;
  Color c2;
  ScrollController controller;
  double height = 150;
  bool top = false;

  @override
  void initState() {
    super.initState();
    tabController = DefaultTabController.of(context);
    c = Color.fromARGB(0, 255, 255, 255);

    c2 = Color.fromARGB(255, 255, 255, 255);
    controller = new ScrollController();
    controller.addListener(() {
      print(controller.position.pixels);
      double x = height / 2;
      if (controller.position.pixels < x) {
        top = true;
        setState(() {
          int a = 255 * controller.position.pixels ~/ x;
          c = Color.fromARGB(0, 255, 255, 255);
          c2 = Color.fromARGB(255 - a, 255, 255, 255);
        });
      } else if (controller.position.pixels < height) {
        top = false;
        setState(() {
          int a = 255 * (controller.position.pixels - x) ~/ x;
          c = Color.fromARGB(a, 255, 255, 255);
          c2 = Color.fromARGB(0, 255, 255, 255);
        });
      }
    });
  }

  gettitle() {
    if (top) {
      return new Row(
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: c2,
          ),
          Text(
            "定位失败0",
            style: TextStyle(color: c2),
          )
        ],
      );
    } else {
      return new Row(
        children: <Widget>[
          Icon(
            Icons.notifications,
            color: c,
          )
        ],
      );
    }
  }

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          leading: Icon(
            Icons.notifications,
            color: c,
          ),
          expandedHeight: height + 50,
          actions: <Widget>[
            Icon(
              Icons.notifications,
              color: c2,
            ),
          ],
          title: gettitle(),
          flexibleSpace: FlexibleSpaceBar(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "11",
                      style: TextStyle(color: c2),
                    ),
                    Text(
                      "22",
                      style: TextStyle(color: c2),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "33",
                      style: TextStyle(color: c2),
                    ),
                    Text(
                      "44",
                      style: TextStyle(color: c2),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}
