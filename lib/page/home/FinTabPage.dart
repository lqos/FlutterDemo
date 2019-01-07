import 'dart:convert' as JSON;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:example01/common/utils/httpnet/Http.dart';
import 'package:example01/common/utils/utils.dart';
import 'package:example01/common/widget/ListViewMore.dart';
import 'package:example01/data/NewWx.dart';
import 'package:flutter/material.dart';

class FindTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindTabState();
}

class _FindTabState extends State<FindTab>
    with AutomaticKeepAliveClientMixin<FindTab> {
  @override
  bool get wantKeepAlive => true;
  List<Tab> tabs;
  List<Widget> tabPages;

  ///避免多次进入
  bool result;

  @override
  void initState() {
    super.initState();
    result = false;
    tabs = [
      Tab(
        text: 'name',
      )
    ];
    tabPages = [new Center(child: new Text('name'))];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (result) {
      return;
    }
    getTabs();
  }

  getTabs() {
    Http.getInstance()
        .get(
            'https://apicloud.mob.com/wx/article/category/query?key=d3cffdd565f5',
            null)
        .then((res) {
      if (res != null && res.data != null) {
        var obj = res.data;
        Map<String, dynamic> user = JSON.jsonDecode(obj);
        LoggerUtils.p(user['msg']);
        var resulte = user['result'];
        if (resulte != null) {
          tabs.clear();
          tabPages.clear();
          setState(() {
            resulte.forEach((v) {
              tabs.add(Tab(
                text: v['name'],
              ));
              tabPages.add(new TabPages(cid: v['cid']));
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LoggerUtils.p(tabs.length);
    LoggerUtils.p(tabPages.length);
    if (tabPages.length > 1) {
      return getV();
    } else {
      return Text('微信精选');
    }
  }

  getV() {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('微信精选'),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: tabs,
            ),
          ),
          body: new TabBarView(
            children: tabPages,
          ),
        ));
  }
}

class TabPages extends StatefulWidget {
  final cid;

  TabPages({this.cid});

  @override
  State<StatefulWidget> createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages>
    with AutomaticKeepAliveClientMixin<TabPages> {
  @override
  Widget build(BuildContext context) {
    return new ListViewMore(
      (int page, int pageSize) {
        return getNews(page, pageSize);
      },
      (int index, Object obj) {
        return _getItem(index, obj);
      },
      pageSize: 15,
    );
  }

  _getItem(index, obj) {
    return Column(
      children: <Widget>[
        Text(index.toString() + ':' + obj.title),
        new CachedNetworkImage(
          placeholder: new CircularProgressIndicator(),
          imageUrl: obj.thumbnails ?? "",
        )
      ],
    );
  }

  getNews(int page, int pageSize) async {
    TabPages w = widget;
    var map = Map<String, dynamic>();
    map['size'] = pageSize.toString();
    map['page'] = page.toString();
    map['cid'] = w.cid;
    map['key'] = 'd3cffdd565f5';
    Response res = await Http.getInstance()
        .get('http://apicloud.mob.com/wx/article/search', map);
    List<NewsWxBean> data = [];
    if (res != null && res.data != null) {
      var obj = res.data;
      Map<String, dynamic> user = JSON.jsonDecode(obj);
      LoggerUtils.p(user['msg']);
      var resulte = user['result'];
      if (resulte != null) {
        resulte['list'].forEach((v) {
          data.add(new NewsWxBean.fromJson(v));
        });
      }
    }
    return data;
  }

  @override
  bool get wantKeepAlive => true;
}
