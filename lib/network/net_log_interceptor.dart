import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 日志打印拦截器，仅在调试模式下输出
/// 使用 'NET' 作为标签，方便过滤
class NetLogInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      var log = '*** Request ***';
      log += '\n${_printKV('uri', options.uri)}';
      log += '\n${_printKV('method', options.method)}';
      log += '\n${_printKV('responseType', options.responseType.toString())}';
      log += '\n${_printKV('followRedirects', options.followRedirects)}';
      log +=
          '\n${_printKV('persistentConnection', options.persistentConnection)}';
      log += '\n${_printKV('connectTimeout', options.connectTimeout)}';
      log += '\n${_printKV('sendTimeout', options.sendTimeout)}';
      log += '\n${_printKV('receiveTimeout', options.receiveTimeout)}';
      log +=
          '\n${_printKV('receiveDataWhenStatusError', options.receiveDataWhenStatusError)}';
      log += '\n${_printKV('extra', options.extra)}';
      log += '\nheaders:';
      options.headers.forEach((key, v) {
        log += '\n${_printKV(' $key', v)}';
      });
      log += '\ndata:';
      log += '\n${jsonEncode(options.data).toString()}';
      _logPrint(log);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      var log = '*** Response ***';
      log += _printResponse(response);
      _logPrint(log);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      var log = '*** DioException ***:';
      log += '\nmethod: ${err.requestOptions.method}';
      log += '\nDioExceptionType: ${err.type}';
      log += '\nerror: ${err.error}';
      if (err.response != null) {
        log += _printResponse(err.response!);
      }
      _logPrint(log);
    }
    handler.next(err);
  }

  String _printResponse(Response response) {
    var log = '';
    log += '\n${_printKV('uri', response.requestOptions.uri)}';
    log += '\n${_printKV('statusCode', response.statusCode)}';
    if (response.isRedirect == true) {
      log += '\n${_printKV('redirect', response.realUri)}';
    }
    log += '\nheaders:';
    response.headers.forEach((key, v) {
      log += '\n${_printKV(' $key', v.join('\r\n\t'))}';
    });
    log += '\nResponse Text:';
    log += '\n${response.toString()}';
    return log;
  }

  String _printKV(String key, Object? v) {
    return '$key: $v';
  }

  void _logPrint(String m) {
    log(m, name: 'NET');
  }
}
