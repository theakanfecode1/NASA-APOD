import 'package:nasa_apod/api_key.dart';
import 'package:nasa_apod/core/network/services/app_dio.dart';
import 'package:nasa_apod/models/apod_image.dart';

class ApodDataSource {
  static Future<List<Apod>> getApods({required int pageNum}) async {
    final response = await AppDio.dio.get('apod',
        queryParameters: {'api_key': nasaApiKey, 'count': pageNum});
    return (response.data as List<dynamic>)
        .map((data) => Apod.fromJson(data))
        .toList(growable: true);
  }
}
