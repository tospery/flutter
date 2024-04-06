import 'package:hi_core/hi_core.dart';
import 'package:hi_network/src/network.dart';

class HiResponse extends HiModel {
  final int? code;
  final String? message;
  final dynamic data;
  final dynamic json;

  const HiResponse({
    this.code,
    this.message,
    this.data,
    this.json,
  });

  factory HiResponse.fromJson(Map<String, dynamic> json) => HiResponse(
    code: convert2Int(json.valueForKeys(HiNetwork.shared().codeKeys)),
    message: convert2String(json.valueForKeys(HiNetwork.shared().messageKeys)),
    data: json.valueForKeys(HiNetwork.shared().dataKeys),
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