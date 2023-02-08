import 'package:hi_flutter/hi_flutter.dart';

class HiResponse extends Equatable {
  final int? code;
  final String? message;
  final dynamic data;
  final dynamic json;

  static const ok = 200;

  const HiResponse({
    this.code,
    this.message,
    this.data,
    this.json,
  });

  factory HiResponse.fromJson(Map<String, dynamic> json) => HiResponse(
        code: hiInt(json.valueForKeys(['code'],),),
        message: hiString(json.valueForKeys(['message', 'msg'],),),
        data: json.valueForKeys(['data'],),
        json: json,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data,
        'json': json,
      };

  HiResponse copyWith({
    int? code,
    String? message,
    dynamic data,
    dynamic json,
  }) {
    return HiResponse(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
      json: json ?? this.json,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [code, message, data, json];
}