class Apod {
  final String title;
  final String date;
  final String m64;
  final String explanation;
  final String url;
  final String hdUrl;

  Apod(
      {required this.title,
      required this.date,
      required this.m64,
      required this.explanation,
      required this.url,
      required this.hdUrl});

  factory Apod.fromJson(Map<String, dynamic> json) => Apod(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      m64: json['M64'] ?? '',
      explanation: json['explanation'] ?? '',
      url: json['url'] ?? '',
      hdUrl: json['hdurl'] ?? '');
}
