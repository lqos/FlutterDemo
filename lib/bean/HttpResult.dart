import 'package:example01/bean/BaseBean.dart';

class HttpResult<T> {
  T data;
  int code;
  String message;

  HttpResult({this.code, this.message, this.data});

  static formJson<T>(Map<String, Object> map, BaseBean bean) {
    if (map == null) {
      return null;
    }
    return new HttpResult(
      code: map["code"],
      data: bean.formJson(map["data"]),
      message: map["message"],
    );
  }
}
