import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod/api_key.dart';
import 'package:nasa_apod/core/network/services/app_dio.dart';
import 'package:nasa_apod/datasource/apod_datasource.dart';
import 'package:nasa_apod/datasource/local_db.dart';
import 'package:nasa_apod/models/apod.dart';

Future<List<Apod>> getApods() async {
  final response = await AppDio.dio.get('apod',
      queryParameters: {'api_key': nasaApiKey, 'count': 10,'thumbs':true});
  return (response.data as List<dynamic>)
      .map((data) => Apod.fromJson(data))
      .toList(growable: true);
}


void main() {
  group('Apod datasource API test', () {
    tearDown(() {
      // Clean up any resources used in the test
      AppDio.dio.close(); // Close the AppDio instance after the test
    });
    test('getApods returns a list of apods', () async {
      // Make the API request and retrieve the response
      final List<Apod> apods = await getApods();

      // Verify that the response is not null and contains valid data
      expect(apods, isNotNull);
      expect(apods, isNotEmpty);

      // Verify the structure and properties of the returned Apod objects
      for (final apod in apods) {
        expect(apod.url, isNotNull);
        expect(apod.title, isNotNull);
        expect(apod.date, isNotNull);
      }
    });
    test('getApods handles error', () async {
      // Arrange

      // Close dio to simulate an error response
      AppDio.dio.close();

      // Act and Assert
      expect(
            () async => getApods(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
