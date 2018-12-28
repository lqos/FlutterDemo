import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example01/bean/NewsBean.dart';
import 'package:example01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  final String ids;

  NewsDetailPage(this.ids);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPageState(ids);
  }
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final String ids;

  _NewsDetailPageState(this.ids);

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String selectUrl = "images/news_detail.html";

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = TextEditingController(text: "");

  //final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    getNewsDetail();
    super.initState();

    flutterWebViewPlugin.close();

    _urlCtrl.addListener(() {
//      selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in Y Direction: $y');
            });
          }
        });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in X Direction: $x');
            });
          }
        });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          if (mounted) {
            setState(() {
              _history.add('onStateChanged: ${state.type} ${state.url}');
            });
          }
        });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
          if (mounted) {
            setState(() {
              _history.add('onHttpError: ${error.code} ${error.url}');
            });
          }
        });
  }

  getNewsDetail() async {
    Response res =
    await Http.getInstance().get(HttpContans.newsDetail + ids, null);
    if (res != null && res.statusCode == 200 && res.data != null) {
      if (res.data['code'] == 1000) {
        NewsBean bean = new NewsBean.fromJson(res.data['data']);
        toload(bean);
      }
    }
  }

  toReplace(String content, String key, String value) {
    List<String> list = content.split(key);
    content = "";
    list.forEach((f) {
      content += (f + value);
      value = "";
    });
    return content;
  }

  toReplace2(String content) {
    List<String> list = content.split('<img ');
    content = "";
    String value = "<img width='100%' height='auto' ";
    list.forEach((f) {
      content += (f + value);
      LoggerUtils.p(f + value);
      if (list.indexOf(f) == list.length - 1) {
        value = '';
      }
    });
    return content;
  }

  toload(NewsBean bean) async {
//    FileUtils.getAppFile();
    String cssStr = await DefaultAssetBundle.of(context)
        .loadString('images/news_detail.html');
    cssStr = toReplace(cssStr, "#news_title#", bean.title);

    cssStr = toReplace(cssStr, "#news_content#", toReplace2(bean.content));
    cssStr = toReplace(cssStr, "#news_source#", bean.createBy);
    cssStr =
        toReplace(cssStr, "#news_puttime#", readTimestamp(bean.createTime));

    File file = await FileUtils.saveNewsDetailFile(cssStr);
    flutterWebViewPlugin.reloadUrl("file:///" + file.path);
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    String time = now.year.toString() +
        '-' +
        now.month.toString() +
        '-' +
        now.day.toString() +
        ' ' +
        now.hour.toString() +
        ':' +
        now.minute.toString() +
        '';

    return time;
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: WebviewScaffold(
        url: selectUrl,
        appBar: AppBar(
          title: const Text('咨讯详情'),
          centerTitle: true,
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Waiting.....'),
          ),
        ),
      ),
    );
  }
}
