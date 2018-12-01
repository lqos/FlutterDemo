class UserLoginBean {
  int code;
  String message;
  String token;
  String userId;
  int type;

  UserLoginBean({this.token, this.type, this.userId, this.code, this.message});

  static formJson(Map<String, Object> map) {
    return new UserLoginBean(
        token: map["token"],
        type: map["type"],
        userId: map["userId"].toString(),
        code: map["code"],
        message: map["message"]);
  }
}
