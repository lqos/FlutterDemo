class NewsBean {
  int classify;
  int collectionCount;
  int commentCount;
  String content;
  String createBy;
  int createTime;
  String desp;
  int goodCount;
  int id;
  int isCollection;
  int isGood;
  String logo;
  int sort;
  int status;
  String tag;
  String title;
  int type;
  int views;

  NewsBean(
      {this.classify,
      this.collectionCount,
      this.commentCount,
      this.content,
      this.createBy,
      this.createTime,
      this.desp,
      this.goodCount,
      this.id,
      this.isCollection,
      this.isGood,
      this.logo,
      this.sort,
      this.status,
      this.tag,
      this.title,
      this.type,
      this.views});

  NewsBean.fromJson(Map<String, dynamic> json) {
    classify = json['classify'];
    collectionCount = json['collectionCount'];
    commentCount = json['commentCount'];
    content = json['content'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    desp = json['desp'];
    goodCount = json['goodCount'];
    id = json['id'];
    isCollection = json['isCollection'];
    isGood = json['isGood'];
    logo = json['logo'];
    sort = json['sort'];
    status = json['status'];
    tag = json['tag'];
    title = json['title'];
    type = json['type'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classify'] = this.classify;
    data['collectionCount'] = this.collectionCount;
    data['commentCount'] = this.commentCount;
    data['content'] = this.content;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['desp'] = this.desp;
    data['goodCount'] = this.goodCount;
    data['id'] = this.id;
    data['isCollection'] = this.isCollection;
    data['isGood'] = this.isGood;
    data['logo'] = this.logo;
    data['sort'] = this.sort;
    data['status'] = this.status;
    data['tag'] = this.tag;
    data['title'] = this.title;
    data['type'] = this.type;
    data['views'] = this.views;
    return data;
  }
}
