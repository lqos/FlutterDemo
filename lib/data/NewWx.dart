class Tabs {
  String cid;
  String name;

  Tabs({this.cid, this.name});

  Tabs.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
  }
}

class NewsWxBean {
  String cid;
  String id;
  String pubTime;
  String sourceUrl;
  String subTitle;
  String thumbnails;
  String title;

  NewsWxBean({
    this.cid,
    this.id,
    this.pubTime,
    this.sourceUrl,
    this.subTitle,
    this.thumbnails,
    this.title,
  });

  NewsWxBean.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    id = json['id'];
    pubTime = json['pubTime'];
    sourceUrl = json['sourceUrl'];
    subTitle = json['subTitle'];
    thumbnails = json['thumbnails'];
    title = json['title'];
  }
}
