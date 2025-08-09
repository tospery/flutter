import 'package:hi_base/src/extension/map.dart';
import 'package:hi_base/src/model/model.dart';

class HiWrap extends HiModel {
  final dynamic data;

  const HiWrap({super.id, this.data});

  factory HiWrap.fromJson(Map<String, dynamic> json) =>
      HiWrap(id: json.stringValue('id'), data: json['data']);

  @override
  Map<String, dynamic> toJson() => {'id': id, 'data': data};

  HiWrap copyWith({String? id, dynamic data}) =>
      HiWrap(id: id ?? this.id, data: data ?? this.data);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, data];
}
