import 'dart:developer';

import 'package:dio/dio.dart';

class LogsInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("🌍 Request [${options.method}] => ${options.path}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("🌍 Response [${response.statusCode}] => ${response.requestOptions.path}");
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("❌🌍❌ Error [${err.response?.statusCode}] => ${err.requestOptions.path} | Details: ${err.response?.data}");
    handler.next(err);
  }
}
