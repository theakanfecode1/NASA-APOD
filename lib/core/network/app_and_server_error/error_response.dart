
class ServerError {
  final dynamic code;

  final String? error;

  final String? message;

  ServerError({this.code, this.error, this.message});

  factory ServerError.fromJson(Map<String,dynamic> json) => ServerError(
    code: json['statusCode'],
    error: json['message'] is List<dynamic> ? List.of(json['message']).first : json['message'] ,
    message: json['message'] is List<dynamic> ? List.of(json['message']).first : json['message'],
  );


}