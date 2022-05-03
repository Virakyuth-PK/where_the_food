// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import 'api_interceptor.dart';
//
// class AppDio {
//   static Dio dio() {
//     var dio = Dio();
//     dio.options.headers["accept"] = "application/json";
//     dio.options.headers['accept'] = 'application/json';
//     dio.options.headers['content-type'] = 'multipart/form-data';
//     dio.options.headers['content-type'] = 'application/json';
//     dio.options.sendTimeout = 10000;
//     dio.options.receiveTimeout = 10000;
//     dio.options.connectTimeout = 10000;
//     dio.interceptors.add(PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90));
//     dio.interceptors.add(getDioInterceptor(dio));
//     return dio;
//   }
//
//   static Dio dioToken(var token) {
//     var dio = AppDio.dio();
//     dio.options.headers['authorization'] = token;
//     dio.interceptors.add(getDioInterceptor(dio));
//     return dio;
//   }
// }
