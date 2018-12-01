import 'package:dio/dio.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';

class Http {
  static Http _http;

  var mHeaders;
  Options options;

  Http() {
    mHeaders = new Map<String, dynamic>();
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

  post(String url, Map<String, Object> map) async {
    String prams = "";
    String pin = "?";
    if (map != null)
      map.forEach((key, value) {
        prams = '$prams$pin$key=$value';
        pin = '&';
      });
    Options options = this.options;
    options.method = "POST";
    options.path = '$url$prams';
    return await netFetch('$url$prams', options);
  }

  get(String url, Map<String, Object> map) async {
    String prams = "";
    String pin = "?";
    if (map != null)
      map.forEach((key, value) {
        prams = '$prams$pin$key=$value';
        pin = '&';
      });
    Options options = this.options;
    options.method = "GET";
    options.path = '$url$prams';
    return await netFetch('$url$prams', options);
  }

  postJson(String url, data) async {
    Options options = this.options;
    options.method = "POST";
    options.data = data;
    options.path = url;
    options.headers["content-type"] = "application/json;charset=UTF-8";
    return await netFetch(url, options);
  }

  void addHeader(String key, dynamic value) {
    mHeaders[key] = value;
    options.headers = mHeaders;
  }

  void remove(List<String> keys) {
    keys.forEach((key) {
      mHeaders.remove(key);
    });
    options.headers = mHeaders;
  }

  netFetch(String url, Options options) async {
    var startTime = new DateTime.now().millisecond;
    var mUrl = options.baseUrl + options.path;
    if (Config.DEBUG) {
      print(
          '********************************************************************');
      print('请求方式:' + options.method + '\n请求地址:$mUrl');
      print('请求参数:' + options.data.toString());
      var headers = options.headers.toString();
      print('请求headers:$headers');
      print(
          '********************************************************************');
    }
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.request(url, options: options);

      if (Config.DEBUG) {
        var time = (new DateTime.now().millisecond - startTime).toString();
        print(
            '********************************************************************');
        print('请求方式:' + options.method + '\n请求地址:$mUrl($time)');
        print('请求结果CODE:' + response.statusCode.toString());
        print('请求结果:' + response.data.toString());
        print(
            '********************************************************************');
      }
      return response;
    } on DioError catch (e) {
      response = e.response;
      if (Config.DEBUG) {
        var time = (new DateTime.now().millisecond - startTime).toString();
        print('请求异常: ' + e.toString());
        print('请求异常url:$mUrl($time)');
      }
      return response;
    }
  }
}
