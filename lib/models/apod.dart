import 'package:hive/hive.dart';

part 'apod.g.dart';

@HiveType(typeId: 0)
class Apod extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String m64;
  @HiveField(3)
  final String explanation;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String hdUrl;

  Apod(
      {required this.title,
      required this.date,
      required this.m64,
      required this.explanation,
      required this.url,
      required this.hdUrl});

  factory Apod.fromJson(Map<dynamic, dynamic> json) => Apod(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      m64: json['M64'] ?? '',
      explanation: json['explanation'] ?? '',
      url: json['thumbnail_url'] ?? json['url'] ?? '',
      // thumbnail_url is for video, if it is not null then the media is video so we use the url for images
      hdUrl: json['hdurl'] ?? '');
}
