///用户详情数据实体
class User extends Object {
  // 命名构造函数
  User.empty();

  String nickName;
  int id;
  String appkey;
  String uuid;
  String udid;
  String portrait;
  String mobile;
  int schoolId;
  int wallet;
  int sex;

  User({
    this.id,
    this.uuid,
    this.udid,
    this.appkey,
    this.nickName,
    this.portrait,
    this.sex,
    this.mobile,
    this.wallet,
    this.schoolId,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
          id: json['id'] as int,
          uuid: json['uuid'] as String,
          udid: json['udid'] as String,
          appkey: json['appkey'] as String,
          nickName: json['nickName'] as String,
          portrait: json['portrait'] as String,
          sex: json['sex'] as int,
          mobile: json['mobile'] as String,
          wallet: json['wallet'] as int,
          schoolId: json['schoolId'] as int);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'nickName': this.nickName,
        'id': this.id,
        'appkey': appkey,
        'uuid': this.uuid,
        'udid': this.udid,
        'portrait': this.portrait,
        'mobile': this.mobile,
        'schoolId': this.schoolId,
        'wallet': this.wallet,
        'sex': this.sex
      };
}
