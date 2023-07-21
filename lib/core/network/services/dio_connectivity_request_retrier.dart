

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {

  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({required this.dio, required this.connectivity});



  Future scheduleRequestRetry(RequestOptions requestOptions,ErrorInterceptorHandler handler,DioException err) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
      streamSubscription?.cancel();
      if(connectivityResult != ConnectivityResult.none){
        if(!responseCompleter.isCompleted){
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                extra: requestOptions.extra,
                contentType: requestOptions.contentType,
                responseType: requestOptions.responseType,
                receiveTimeout: requestOptions.receiveTimeout,
                sendTimeout: requestOptions.sendTimeout,
                validateStatus: requestOptions.validateStatus,
                followRedirects: requestOptions.followRedirects,
                maxRedirects: requestOptions.maxRedirects,
              ),
            ),
          );
        }
      }
      else{
        handler.next(err);
      }
    });
    return responseCompleter.future;
  }

}