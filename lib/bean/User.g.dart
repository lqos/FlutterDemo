// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
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
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nickName': instance.nickName,
      'id': instance.id,
      'appkey': instance.appkey,
      'uuid': instance.uuid,
      'udid': instance.udid,
      'portrait': instance.portrait,
      'mobile': instance.mobile,
      'schoolId': instance.schoolId,
      'wallet': instance.wallet,
      'sex': instance.sex
    };
