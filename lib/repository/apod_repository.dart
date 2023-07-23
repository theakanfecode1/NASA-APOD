import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/datasource/apod_datasource.dart';
import 'package:nasa_apod/models/apod.dart';


final apodRepositoryProvider =
Provider<ApodRepository>((ref) => ApodRepository());

class ApodRepository {

  Future<List<Apod>> getApods() {
    return ApodDataSource.getApods();
  }

}
