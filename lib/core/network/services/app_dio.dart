import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:nasa_apod/core/network/services/retry_interceptor.dart';

import 'dio_connectivity_request_retrier.dart';

class AppDio with DioMixin implements Dio {
  AppDio._() {
    options = BaseOptions(
      baseUrl: 'https://api.nasa.gov/planetary/',
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    httpClientAdapter = IOHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();

  static Dio dio = AppDio.getInstance();
}
