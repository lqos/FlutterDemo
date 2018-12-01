import 'package:dio/dio.dart';
import 'package:example01/utils/PreferencesUtils.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';

class Http {
  static Http _http;

  var mHeaders;
  Options options;

  Http() {
    mHeaders = new Map<String, dynamic>();
    PreferencesUtils.getString("token", "").then((String token) {
      mHeaders["token"] = token;
      options.headers = mHeaders;
    });
    PreferencesUtils.getString("userId", "").then((String userId) {
      mHeaders["userId"] = userId;
      options.headers = mHeaders;
    });
    options = new Options();
    options.baseUrl = HttpContans.baseUrl;
    options.connectTimeout = 15000;
    options.receiveTimeout = 15000;
    options.headers = mHeaders;
  }

  static Http getInstance() {
    if (_http == null) {
      _http = new Http();
    }
    return _http;
  }

  get<T>(String url, Map<String, Object> map) {
    String prams = "";
    String pin = "?";
    if (map != null)
      map.forEach((key, value) {
        prams = '$pin$key=$value';
        pin = '&';
      });
    Dio dio = new Dio();
    print('$url$prams');
    return dio.get('$url$prams', options: options);
  }

  postJson(String url, data) {
    Dio dio = new Dio();
    print(url);
    Options options = this.options;
    options.headers["content-type"] = "application/json;charset=UTF-8";
    print(options.toString());
    return dio.post(url, data: data, options: options);
  }

  text() => {};

  void addHeader(String key, dynamic value) {
    mHeaders[key] = value;
    options.headers = mHeaders;
  }
}
