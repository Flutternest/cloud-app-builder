import 'package:dio/dio.dart';

abstract class HttpService {
  String get baseUrl;

  Map<String, String> get headers;

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> put();

  Future<dynamic> delete();
}
