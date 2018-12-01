import 'package:dio/dio.dart';
import 'package:example01/bean/NewsBean.dart';
import 'package:example01/common/config/config.dart';
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

  @override
  void initState() {
    super.initState();
    data = List();
    print("_MenusDemoState initState");
    getNews();
  }

  @override
  void dispose() {
    super.dispose();
    data.clear();
    print("_MenusDemoState dispose");
  }

  getNews() async {
    var map = Map<String, dynamic>();
    map["size"] = "15";
    map["type"] = "1";
    map["userId"] = await PreferencesUtils.getString(Config.USER_ID, "0");
    map["page"] = "1";
    Response res = await Http.getInstance().get(HttpContans.news, map);
    if (res != null && res.data != null) {
      print(res.data['code']);
      print(res.data['message']);
      var resulte = res.data['data'];
      if (resulte != null)
        resulte.forEach((v) {
          data.add(new NewsBean.fromJson(v));
        });
    }
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
    getNews();
  }

  Widget _getItem(index) {
    NewsBean bean = data[index];
    double w = DensityUtil.getwx(context, 16);
    double imageWidth = DensityUtil.getwx(context, 100);
    return new Container(
      padding: EdgeInsets.all(w),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            width:
            DensityUtil.getwx(context, DensityUtil.DW) - w * 3 - imageWidth,
            child: new Column(
              children: <Widget>[
                new Text(
                  "${bean.title}",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: new TextStyle(
                      fontSize: DensityUtil.getwx(context, 15),
                      color: Color(0xff0f0f0f)),
                ),
                new Text(
                  "${bean.desp}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: new TextStyle(
                      fontSize: DensityUtil.getwx(context, 12),
                      color: Color(0xff848484)),
                ),
                new Row(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(
                            width: 1.0, color: Color(0xFFE2F2FF)),
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
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
                    Icon(
                      Icons.remove_red_eye,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 15,
                    ),
                    new Text(
                      bean.commentCount.toString() ?? "0",
                      style: TextStyle(color: Color(0xff979797)),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 15,
                    ),
                    new Text(
                      bean.goodCount.toString() ?? "0",
                      style: TextStyle(color: Color(0xff979797)),
                    ),
                  ],
                )
              ],
            ),
          ),
          new Image.network(
            bean.logo ?? "",
            width: imageWidth,
            height: imageWidth * 102 / 141,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
