import 'package:example01/bean/BaseBean.dart';

class User extends BaseBean {
  static User _user;

  static User getInstance() {
    if (_user == null) {
      _user = new User();
    }
    return _user;
  }

  // 命名构造函数
//  User.empty();

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

//  {id: 288,
// appkey: C9469CAC888572A386036A62D1002F31,
// uuid: 8956337943A5E74147E5082BCF4AB678,
// udid: CCD6E285D9D57CA43B10561F3C7003E1,
// nickName: M77235守护,
// status: 1,
// sex: 1,
// birthday: ,
// mobile: 18232077504,
// email: , score: 0,
// wallet: 0,
// portrait: http://nebulaedu.com/static//head/20180327/288/288066953.png, background: , accountName: null, type: 1, attentionCount: 0, collectCount: 0, autograph: null, osName: , openId: null, unionId: null, vip: 0, qqOpenid: null, schoolId: 1}
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

  formJson(Map<String, Object> map) {
    getInstance();
    _user.id = map["id"];
    _user.appkey = map["appkey"];
    _user.uuid = map["uuid"];
    _user.udid = map["udid"];
    _user.nickName = map["nickName"];
    _user.portrait = map["portrait"];
    _user.sex = map["sex"];
    _user.schoolId = map["schoolId"];
    _user.mobile = map["mobile"];
    _user.wallet = map["wallet"];
  }

  @override
  String toString() {
    return super.toString();
  }
}
