import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_and_server_error/app_error.dart';

part 'result.freezed.dart';

class RequestStateNotifier<T> extends StateNotifier<RequestState<T>> {
  RequestStateNotifier() : super(const RequestState.idle());

  Future<RequestState<T>> makeRequest(Future<T> Function() function) async {
    try {
      state = RequestState<T>.loading();
      final response = await function();
      final newState = RequestState<T>.success(response);
      if (mounted) {
        state = newState;
      }
      return newState;
    } on Exception catch (e) {
      if (e is DioException) {}
      final newState = RequestState<T>.error(AppError(e));
      if (mounted) {
        state = newState;
      }
      return newState;
    }
  }
  // This function is used to get more data (pagination or drag to refresh) without changing the state notifier to RequestState<T>.loading()
  Future<RequestState<T>> fetchMoreData(Future<T> Function() function,
      {bool isRefresh = false}) async {
    try {
      final response = await function();
      final currentData = ((getSuccessData() ?? []) as List<dynamic>);
      final newItems = (!isRefresh
          ? currentData + (response as List<dynamic>)
          : (response as List<dynamic>)  + currentData ) as T;
      final newState = RequestState<T>.success(newItems);
      if (mounted) {
        state = newState;
      }
      return newState;
    } on Exception catch (e) {
      if (e is DioException) {}
      final newState = RequestState<T>.error(AppError(e));
      if (mounted) {
        state = newState;
      }
      return newState;
    }
  }

  dynamic getSuccessData() {
    return state.when(
        idle: () {},
        loading: () {},
        success: (data) => data,
        error: (error) {});
  }
}

@freezed
class RequestState<T> with _$RequestState<T> {
  const factory RequestState.idle() = Idle<T>;

  const factory RequestState.loading() = Loading<T>;

  const factory RequestState.success(T value) = Success<T>;

  const factory RequestState.error(AppError error) = Failure<T>;
}
