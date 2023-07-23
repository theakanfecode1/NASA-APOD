import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/datasource/apod_datasource.dart';
import 'package:nasa_apod/datasource/local_db.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/utils/connection_status.dart';


final apodRepositoryProvider =
Provider<ApodRepository>((ref) => ApodRepository());

class ApodRepository {

  Future<List<Apod>> getApods() async {
    if (await ConnectionStatus.isOnline()) {
      return ApodDataSource.getApods();
    }
    else{
      return LocalDb.getCachedApods();
    }
  }
}