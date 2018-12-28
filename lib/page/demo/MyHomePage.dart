import 'package:example01/utils/utils.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin, SingleTickerProviderStateMixin {
  Color c;
  Color c2;
  ScrollController controller;
  double height = 150;
  double wh = 45;
  double wh2 = 30;
  bool top = true;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    c = Color.fromARGB(0, 255, 255, 255);

    c2 = Color.fromARGB(255, 255, 255, 255);
    controller = new ScrollController();
    controller.addListener(() {
      LoggerUtils.p(controller.position.pixels);
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

  /*对应消息点击事件*/
  onclickMessage() {
    LoggerUtils.p("消息");
  }

  /*对应附近设备点击事件*/
  onclickNear() {
    LoggerUtils.p("附近");
  }

  /*对应扫一扫点击事件*/
  onclickScan() {
    LoggerUtils.p("扫一扫");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          leading: InkWell(
            onTap: onclickScan,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('images/ic_zxing.png',
                  height: DensityUtil.getwx(context, wh2),
                  width: DensityUtil.getwx(context, wh2),
                  color: c),
            ),
          ),
          expandedHeight: height + 48,
          actions: <Widget>[
            InkWell(
                onTap: onclickMessage,
                child: Icon(
                  Icons.notifications,
                  color: c2,
                )),
          ],
          title: titleWidget(),
          flexibleSpace: new Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  scanfWithTextWidget(),
                  nearDeviceWithTextWidget(),
                ]),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
              minHeight: 50, maxHeight: 50, child: topTab()),
        ),
        SliverFillViewport(
            delegate: _SliverChildDelegate(
                minHeight: 300, maxHeight: 300, child: tabBarView())),
      ],
    );
  }

  //扫一扫
  Widget scanfWithTextWidget() {
    return InkWell(
        onTap: onclickScan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/ic_zxing.png',
                height: DensityUtil.getwx(context, top ? wh : 0),
                width: DensityUtil.getwx(context, top ? wh : 0),
                color: c2),
            Text(
              "扫一扫",
              style: TextStyle(color: c2, fontSize: 10),
            )
          ],
        ));
  }

  //附近
  Widget nearDeviceWithTextWidget() {
    return InkWell(
        onTap: onclickNear,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/ic_fujin.png',
              color: c2,
              height: DensityUtil.getwx(context, top ? wh : 0),
              width: DensityUtil.getwx(context, top ? wh : 0),
            ),
            Text(
              "附近设备",
              style: TextStyle(color: c2, fontSize: 10),
            )
          ],
        ));
  }

  topTab() {
    return Container(
      color: Colors.white,
      child: new TabBar(
        onTap: (index) {
          LoggerUtils.p(index.toString());
        },
        tabs: <Widget>[
          new Tab(
            icon: new Icon(Icons.directions_bike,
                color: Theme
                    .of(context)
                    .accentColor),
          ),
          new Tab(
            icon: new Icon(Icons.directions_boat,
                color: Theme
                    .of(context)
                    .accentColor),
          ),
        ],
        controller: _tabController,
      ),
    );
  }

  tabBarView() {
    return TabBarView(controller: _tabController, children: [
      new Container(
          child: new Column(
            children: <Widget>[
              Text('自行车'),
              Text('自行车'),
              Text('自行车'),
            ],
          )),
      new Container(
          child: new Column(
            children: <Widget>[
              Text('船'),
              Text('船'),
              Text('船'),
            ],
          )),
    ]);
  }

  Widget titleWidget() {
    if (top) {
      return new Row(
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: c2,
          ),
          Text(
            "定位失败",
            style: TextStyle(color: c2),
          )
        ],
      );
    } else {
      return InkWell(
        onTap: onclickNear,
        child: Image.asset('images/ic_fujin.png',
            height: DensityUtil.getwx(context, wh2),
            width: DensityUtil.getwx(context, wh2),
            color: c),
      );
    }
  }
}

class HomeTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
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
    );
  }
}

class _SliverChildDelegate extends SliverChildDelegate {
  _SliverChildDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  int get estimatedChildCount => 1;

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, int index) => child;

  @override
  bool shouldRebuild(_SliverChildDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
