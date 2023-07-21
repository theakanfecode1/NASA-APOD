import 'dart:io';

import 'package:dio/dio.dart';

import 'error_response.dart';

enum AppErrorType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
  notFound,
}

class AppError {
  String? message;
  AppErrorType? type;
  ServerError? serverError;

  AppError(Exception error) {
    if (error is DioException) {
      message = error.message;
      if (error.error is SocketException) {
        type = AppErrorType.network;
        return;
      }
      if (error.response != null) {
        serverError = ServerError.fromJson(
            error.response!.data is Map<String, dynamic>
                ? error.response!.data
                : {'message': 'An error occurred'});
      }
      switch (error.type) {
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = AppErrorType.network;
          } else {
            type = AppErrorType.unknown;
          }
          break;
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          type = AppErrorType.timeout;
          break;
        case DioExceptionType.sendTimeout:
          type = AppErrorType.network;
          break;
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case HttpStatus.badRequest: // 400
              type = AppErrorType.badRequest;
              break;
            case HttpStatus.unauthorized: // 401
              type = AppErrorType.unauthorized;
              break;
            case HttpStatus.internalServerError: // 500
              type = AppErrorType.server;
              break;
            case HttpStatus.badGateway: // 502
              type = AppErrorType.server;
              break;
            case HttpStatus.serviceUnavailable: // 503
              type = AppErrorType.server;
              break;
            case HttpStatus.notFound:
              type = AppErrorType.notFound;
              break;
            case HttpStatus.gatewayTimeout: // 504
              type = AppErrorType.server;
              break;
            default:
              type = AppErrorType.unknown;
              break;
          }
          break;
        case DioExceptionType.cancel:
          type = AppErrorType.cancel;
          break;
        default:
          type = AppErrorType.unknown;
      }
    } else {
      type = AppErrorType.unknown;
      message = '$error';
    }
  }
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}
