import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage(String ids);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPageState();
  }
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("咨讯详情"),
        centerTitle: true,
      ),
      body: new Container(
        child: new Text("wewwwww"),
      ),
    );
  }
}
