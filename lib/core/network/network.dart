import 'dart:io';

import 'package:demo_project/core/error/failures.dart';
import 'package:demo_project/core/network/api.dart';
import 'package:dio/dio.dart';

class Network {
  final int _timeOut = 60000; //60s
  late Dio _dio;

  Network() {
    BaseOptions options = BaseOptions(
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      baseUrl: Api.baseUrl,
    );
    Map<String, dynamic> headers = {};
    /*
    Http request headers.
   */
    headers["content-type"] = "application/json";
    headers["Accept"] = "application/json";
    options.headers = headers;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> get({required String url, Map<String, dynamic> params = const {}}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json),
      );
      return _handleResponse(response, url);
    } catch (e) {
      //handle error
      throw _handleError(e, url);
    }
  }

  Response _handleResponse(Response response, url) {
    if (response.statusCode != 200) {
      throw DioError(
        requestOptions: RequestOptions(
          path: url,
        ),
        type: DioErrorType.response,
        response: response,
      );
    }
    return response;
  }

  ResponseFailure _handleError(dynamic error, String url) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.other:
            if (error.error is SocketException) {
              return ResponseFailure(
                data: error.error,
                statusMessage: error.message,
                statusCode: ResponseFailure.networkErrorCode,
                path: url,
              );
            }
            return ResponseFailure(
              data: error.error,
              statusMessage: error.message,
              path: url,
            );
          case DioErrorType.response:
            return ResponseFailure(
              data: error.response?.data,
              statusMessage: error.response!.statusMessage,
              statusCode: error.response!.statusCode,
              path: url,
            );
          default:
            return ResponseFailure(
              data: error.error,
              statusMessage: error.message,
              path: url,
            );
        }
      }
    } catch (ex) {
      return ResponseFailure(data: ex.toString(), path: url);
    }
    return ResponseFailure(data: error.toString(), path: url);
  }
}
