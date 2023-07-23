import 'package:hive_flutter/hive_flutter.dart';

import '../models/apod.dart';

class LocalDb {
  static const String boxName = 'apod_box';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ApodAdapter());
    await Hive.openBox(boxName);
  }

  static Box<dynamic> _getApodBox() {
    return Hive.box(boxName);
  }

  static List<Apod> getCachedApods() {
    final apodBox = _getApodBox();
    return (List.from(apodBox.get(boxName, defaultValue: [])));
        // .map((data) => Apod.fromJson(data))
        // .toList(growable: true);
    }

  static Future<void> cacheApods(List<dynamic> apods) async {
    final apodBox = _getApodBox();
    await apodBox.put(boxName, apods);
  }

  static Future<void> clear() async {
    final apodBox = _getApodBox();
    await apodBox.deleteFromDisk();
  }


}
