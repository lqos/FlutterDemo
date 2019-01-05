import 'package:example01/common/utils/utils.dart';
import 'package:flutter/material.dart';

class Demo2 extends StatefulWidget {
  @override
  Demo2State createState() {
    return new Demo2State();
  }
}

class Demo2State extends State<Demo2> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  expandedHeight: DensityUtil.getSW(context) * 17 / 25,
                  // 这个高度必须比flexibleSpace高度大
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                      child: new Container(
                        color: Colors.amber,
                        child: new TabBar(
                          tabs: [
                            new Tab(
                              text: "当前",
                            ),
                            new Tab(
                              text: "订单",
                            )
                          ],
                        ),
                      ),
                      preferredSize: new Size(double.infinity, 46.0)),
                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                  flexibleSpace: new Container(
                    child: new Column(
                      children: <Widget>[
                        new AppBar(
                          title: Text("this is title"),
                        ),
                        new Expanded(
                          child: new Container(
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      new AssetImage("images/ic_user_bg.webp"),
                                  fit: BoxFit.fill),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.share),
                                Icon(Icons.share)
                              ],
                            ),
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: [
              new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CustomScrollView(
                      slivers: <Widget>[
                        new SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: new SliverFixedExtentList(
                            itemExtent: 1,
                            delegate: new SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return new Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new Text("88888"),
                                );
                              },
                              childCount: 2,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CustomScrollView(
                      slivers: <Widget>[
                        new SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: new SliverFixedExtentList(
                            itemExtent: 1,
                            delegate: new SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return new Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new Text("88888"),
                                );
                              },
                              childCount: 2,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
