import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/core/network/services/result.dart';
import 'package:nasa_apod/repository/apod_repository.dart';


final apodViewModelStateNotifierProvider =
    StateNotifierProvider<ApodViewModel, RequestState>(
        (ref) => ApodViewModel(ref.read(apodRepositoryProvider)));

class ApodViewModel extends RequestStateNotifier<void> {
  final ApodRepository _apodRepository;

  ApodViewModel(this._apodRepository);

  Future<void> getApods({required int pageNum}) =>
      makeRequest(() => _apodRepository.getApods(pageNum: pageNum));

  Future<void> getPaginatedApods({required int pageNum}) =>
      fetchNextPage(() => _apodRepository.getApods(pageNum: pageNum));
}
