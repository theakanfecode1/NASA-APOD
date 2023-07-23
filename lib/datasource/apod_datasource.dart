import 'package:nasa_apod/api_key.dart';
import 'package:nasa_apod/core/network/services/app_dio.dart';
import 'package:nasa_apod/datasource/local_db.dart';
import 'package:nasa_apod/models/apod.dart';

class ApodDataSource {
  static Future<List<Apod>> getApods() async {
    final response = await AppDio.dio.get('apod',
        queryParameters: {'api_key': nasaApiKey, 'count': 10,'thumbs':true});
    /*The count is set to 10 by default because the APOD API lacks pagination options like page or pageNum.
    Therefore, I use 'count' for pagination, which returns randomly selected images. */
    List<Apod> apods = (response.data as List<dynamic>)
        .map((data) => Apod.fromJson(data))
        .toList(growable: true);
    LocalDb.cacheApods(apods);
    return apods;
  }
}
