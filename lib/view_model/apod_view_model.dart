import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/core/network/services/result.dart';
import 'package:nasa_apod/repository/apod_repository.dart';


final apodViewModelStateNotifierProvider =
    StateNotifierProvider<ApodViewModel, RequestState>(
        (ref) => ApodViewModel(ref.read(apodRepositoryProvider)));

class ApodViewModel extends RequestStateNotifier<void> {
  final ApodRepository _apodRepository;

  ApodViewModel(this._apodRepository);

  Future<void> getApods() =>
      makeRequest(() => _apodRepository.getApods());

  Future<void> fetchMoreApods({bool isRefresh = false}) =>
      fetchMoreData(() => _apodRepository.getApods(),isRefresh: isRefresh);
}
