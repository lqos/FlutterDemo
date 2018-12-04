import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';
// user.g.dart 将在我们运行生成命令后自动生成

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
