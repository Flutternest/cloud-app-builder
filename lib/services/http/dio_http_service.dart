import 'package:automation_wrapper_builder/exceptions/http_exception.dart';
import 'package:dio/dio.dart';

import '../../constants/app_configs.dart';
import 'dio_interceptors/logs_interceptor.dart';
import 'http_service.dart';

class DioHttpService implements HttpService {
  late final Dio dio;

  DioHttpService({
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    dio.interceptors.add(LogsInterceptor());
  }

  @override
  String get baseUrl => Configs.apiBaseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  Future<void> handleExceptions(Function function) async {
    try {
      return await function();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw HttpException(
          title: "Connection Timeout Exception",
          message: "Connection has been timeout",
          statusCode: e.response?.statusCode,
        );
      }

      if (e.type == DioErrorType.response) {
        String errorMessage = "Something went wrong";
        final responseData = (e.response?.data as Map?);

        if (responseData?.containsKey("Message") ?? false) {
          if (responseData!["Message"] ==
              "Authorization has been denied for this request.") {
            errorMessage = "Session has been expired. Please login again";
          }
        }

        if ((responseData?.containsKey("MESSAGE") ?? false)) {
          errorMessage = responseData!["MESSAGE"];
        }

        if ((responseData?.containsKey("Message") ?? false)) {
          errorMessage = responseData!["Message"];
        }

        if ((responseData?.containsKey("error_description") ?? false)) {
          errorMessage = responseData!["error_description"];
        }

        throw HttpException(
          title: "Http Error!",
          message: errorMessage,
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw HttpException(
          title: "Http Error!", message: "Something went wrong");
    }
  }

  @override
  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      CancelToken? cancelToken}) {
    return handleExceptions(() async {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      if (response.data == null || response.statusCode != 200) {
        throw HttpException(
          title: 'Http Error!',
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }

      return response.data;
    });
  }

  @override
  Future<dynamic> post(String endpoint,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      Map<String, dynamic>? headers}) async {
    return handleExceptions(() async {
      Response response = await dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      if (response.data == null || response.statusCode != 200) {
        throw HttpException(
          title: 'Http Error!',
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }
      return response.data;
    });
  }

  @override
  Future delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future put() {
    // TODO: implement put
    throw UnimplementedError();
  }
}
