

class HttpResult<T> {
  T data;
  int code;
  String message;

  HttpResult({this.code, this.message, this.data});

  static formJson<T>(Map<String, Object> map) {
    if (map == null) {
      return null;
    }
    return new HttpResult(
      code: map["code"],
      message: map["message"],
    );
  }
}
