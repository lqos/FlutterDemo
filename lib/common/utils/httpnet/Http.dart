import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example01/common/config/config.dart';
import 'package:example01/common/utils/utils.dart';

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

  postImage(String url, Map<String, Object> map, var file) async {
    String prams = "";
    String pin = "?";
    if (map != null)
      map.forEach((key, value) {
        prams = '$prams$pin$key=$value';
        pin = '&';
      });
    Options options = this.options;
    options.method = "POST";
    options.data = file;
    options.contentType = ContentType.binary;
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
    options.contentType = ContentType.json;
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
      LoggerUtils.p(
          '********************************************************************');
      LoggerUtils.p('请求方式:' + options.method + '\n请求地址:$mUrl');
      LoggerUtils.p('请求参数:' + options.data.toString());
      var headers = options.headers.toString();
      LoggerUtils.p('请求headers:$headers');
      LoggerUtils.p(
          '********************************************************************');
    }
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.request(url, options: options);

      if (Config.DEBUG) {
        var time = (new DateTime.now().millisecond - startTime).toString();
        LoggerUtils.p(
            '********************************************************************');
        LoggerUtils.p('请求方式:' + options.method + '\n请求地址:$mUrl($time)');
        LoggerUtils.p('请求结果CODE:' + response.statusCode.toString());
        LoggerUtils.p('请求结果:' + response.data.toString());
        LoggerUtils.p(
            '********************************************************************');
      }
      return response;
    } on DioError catch (e) {
      response = e.response;
      if (Config.DEBUG) {
        var time = (new DateTime.now().millisecond - startTime).toString();
        LoggerUtils.p('请求异常: ' + e.toString());
        LoggerUtils.p('请求异常url:$mUrl($time)');
      }
      return response;
    }
  }
}
