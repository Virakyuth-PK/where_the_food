import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';

import 'api_interceptor.dart';

class Http {

  static Dio _create({bool useProxy = false, String? token, required bool showLoading}) {
    Dio? _dio = Dio();
    _dio.options.headers["accept"] = "application/json";
    _dio.options.headers['accept'] = 'application/json';
    _dio.options.headers['content-type'] = 'multipart/form-data';
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.sendTimeout = SEND_TIMEOUT;
    _dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    _dio.options.connectTimeout = CONNECT_TIMEOUT;
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.interceptors.add(getDioInterceptor(_dio, showLoading: showLoading));
    if (token != null) {
      Logger().wtf("token in dio $token");
      _dio.options.headers['authorization'] = token;
    }
    if (useProxy) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
        client.findProxy = (uri) {
          return testingBaseUrl;
        };
        return null;
      };
    }
    return _dio;
  }

  Future<void> get(String url,
      {required Function(dynamic) onSuccess,
      Function(dynamic error)? onError,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      String? token,
      required bool showLoading}) async {
    try {
      await _create(token: token, showLoading: showLoading)
          .get(testingBaseUrl + url,
              queryParameters: params, options: Options(headers: headers))
          .then((value) async => {await onSuccess(value.data)});
      // .catchError((error) => onError!(error));
    } catch (error, stacktrace) {
      Logger().e("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  Future<void> post(String url,
      {required Function(dynamic) onSuccess,
      Function(dynamic error)? onError,
      dynamic body,
      Map<String, dynamic>? headers,
      String? token,
      required bool showLoading}) async {
    try {
      Logger().e("here post $token");
      await _create(token: token, showLoading: showLoading)
          .post(testingBaseUrl + url,
              data: body, options: Options(headers: headers))
          .then((value) async => {await onSuccess(value.data)});
      // .catchError((error) => onError!(error));
    } catch (error, stacktrace) {
      Logger().e("Exception occurred: $error stackTrace: $stacktrace");
    }
  }
}
