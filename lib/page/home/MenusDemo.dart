import 'package:dio/dio.dart';
import 'package:example01/bean/NewsBean.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/common/widget/LineView.dart';
import 'package:example01/utils/DensityUtil.dart';
import 'package:example01/utils/PreferencesUtils.dart';
import 'package:example01/utils/httpnet/Http.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenusDemo extends StatefulWidget {
  @override
  _MenusDemoState createState() {
    return new _MenusDemoState();
  }
}

class _MenusDemoState extends State<MenusDemo>
    with AutomaticKeepAliveClientMixin<MenusDemo> {
  List<NewsBean> data;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    data = List();
    print("_MenusDemoState initState");
    getNews(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        getNews(page + 1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    data.clear();
    print("_MenusDemoState dispose");
  }

  getNews(int page) async {
    if (loading) {
      return;
    }
    loading = true;
    int size = 15;
    var map = Map<String, dynamic>();
    map["size"] = size.toString();
    map["type"] = "1";
    map["userId"] = await PreferencesUtils.getString(Config.USER_ID, "0");
    map["page"] = page.toString();
    Response res = await Http.getInstance().get(HttpContans.news, map);
    if (res != null && res.data != null) {
      print(res.data['code']);
      print(res.data['message']);
      var resulte = res.data['data'];
      if (resulte != null) {
        if (page == 1) {
          data.clear();
        }
        resulte.forEach((v) {
          size -= 1;
          data.add(new NewsBean.fromJson(v));
        });

        if (size > 0 && this.page > 1) {
          this.page = page - 1;
        } else {
          this.page = page;
        }
      }
    }
    loading = false;
    setState(() {});
  }

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
      body: RefreshIndicator(
          child: new ListView.builder(
            ///根据状态返回子孔健
            itemBuilder: (context, index) {
              return _getItem(index);
            },
            controller: _scrollController,

            ///根据状态返回数量
            itemCount: _getListCount(),
          ),
          onRefresh: _onRefresh),
    );
  }

  _getListCount() {
    return data.length;
  }

  Future<Null> _onRefresh() async {
    page = 1;
    getNews(1);
  }

  Widget _getItem(index) {
    NewsBean bean = data[index];
    double w = DensityUtil.getwx(context, 16);
    double imageWidth = DensityUtil.getwx(context, 110);
    return new Column(
      children: <Widget>[
        index != 0
            ? LineView(
          length: null,
        )
            : LineView.line,
        Container(
          padding: EdgeInsets.all(w),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                width: DensityUtil.getwx(context, DensityUtil.DW) -
                    w * 2.8 -
                    imageWidth,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "${bean.title}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: new TextStyle(
                          fontSize: DensityUtil.getwx(context, 13),
                          color: Color(0xff0f0f0f)),
                    ),
                    new Container(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            DensityUtil.getwx(context, 5),
                            0,
                            DensityUtil.getwx(context, 2)),
                        child: new Text(
                          "${bean.desp}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: new TextStyle(
                              fontSize: DensityUtil.getwx(context, 10.4),
                              color: Color(0xff848484)),
                        )),
                    new Container(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          DensityUtil.getwx(context, 5),
                          0,
                          DensityUtil.getwx(context, 5)),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                  width: 1.0, color: Color(0xFFE2F2FF)),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(20.0)),
                              color: Color(0xFFE2F2FF),
                            ),
                            padding: EdgeInsets.fromLTRB(
                                DensityUtil.getwx(context, 10),
                                DensityUtil.getwx(context, 2),
                                DensityUtil.getwx(context, 10),
                                DensityUtil.getwx(context, 2)),
                            child: new Text(
                              "${bean.tag}",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: new TextStyle(
                                  fontSize: DensityUtil.getwx(context, 11),
                                  color: Color(0xFF0F86E1)),
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.fromLTRB(
                                DensityUtil.getwx(context, 10),
                                DensityUtil.getwx(context, 2),
                                DensityUtil.getwx(context, 5),
                                DensityUtil.getwx(context, 2)),
                            child: new Row(
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  size: 15,
                                ),
                                new Container(
                                  padding: EdgeInsets.fromLTRB(
                                      DensityUtil.getwx(context, 5), 0, 0, 0),
                                  child: new Text(
                                    bean.commentCount.toString() ?? "0",
                                    style: TextStyle(color: Color(0xff979797)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.fromLTRB(
                                DensityUtil.getwx(context, 5),
                                DensityUtil.getwx(context, 2),
                                DensityUtil.getwx(context, 5),
                                DensityUtil.getwx(context, 2)),
                            child: new Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  size: 15,
                                ),
                                new Container(
                                  padding: EdgeInsets.fromLTRB(
                                      DensityUtil.getwx(context, 5), 0, 0, 0),
                                  child: new Text(
                                    bean.goodCount.toString() ?? "0",
                                    style: TextStyle(color: Color(0xff979797)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: new Image.network(
                  bean.logo ?? "",
                  width: imageWidth,
                  height: imageWidth * 102 / 141,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
