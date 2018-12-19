import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:example01/bean/NewsBean.dart';
import 'package:example01/common/config/Nav.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/common/widget/LineView.dart';
import 'package:example01/common/widget/ListViewMore.dart';
import 'package:example01/utils/AppUtils.dart';
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
  @override
  void initState() {
    super.initState();
    print("MyHomePageState initState");
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    print("MyHomePageState dispose");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("发现"),
        centerTitle: true,
      ),
      body: getContent(),
    );
  }

  getContent() {
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

  getNews(int page, int pageSize) async {
    var map = Map<String, dynamic>();
    map["size"] = pageSize.toString();
    map["page"] = page.toString();
    map["type"] = "1";
    if (AppUtils.checkLoin(context))
      map["userId"] = await PreferencesUtils.getString(Config.USER_ID, "0");

    Response res = await Http.getInstance().get(HttpContans.news, map);
    List<NewsBean> data = [];
    if (res != null && res.data != null) {
      print(res.data['code']);
      print(res.data['message']);
      var resulte = res.data['data'];
      if (resulte != null) {
        resulte.forEach((v) {
          data.add(new NewsBean.fromJson(v));
        });
      }
    }
    return data;
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getItem(int index, Object obj) {
    NewsBean bean = obj;
    double w = DensityUtil.getwx(context, 16);
    double imageWidth = DensityUtil.getwx(context, 110);
    return new Column(
      children: <Widget>[
        index != 0
            ? LineView(
          length: null,
        )
            : LineView.line,
        InkWell(
          onTap: () {
            Nav.goNewsDetailPage(context, bean.id.toString());
          },
          child: Container(
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
                                      style:
                                      TextStyle(color: Color(0xff979797)),
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
                                      style:
                                      TextStyle(color: Color(0xff979797)),
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
                  child: new CachedNetworkImage(
                    placeholder: new CircularProgressIndicator(),
                    imageUrl: bean.logo ?? "",
                    width: imageWidth,
                    height: imageWidth * 102 / 141,
                  ) /* new Image.network(
                    bean.logo ?? "",
                    width: imageWidth,
                    height: imageWidth * 102 / 141,
                  )*/
                  ,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
