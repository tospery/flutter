import 'package:flutter/material.dart';
import 'model.dart';
import 'package:hi_core/src/datatype.dart';
import 'package:hi_core/src/logger.dart';
import 'package:hi_core/src/extension/map.dart';

class HiWrap extends HiModel {
  final dynamic data;

  const HiWrap({
    super.id,
    this.data,
  });

  factory HiWrap.fromJson(Map<String, dynamic> json) => HiWrap(
    id: json.value<String>('id'),
    data: json['data'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
  };

  HiWrap copyWith({
    String? id,
    dynamic data,
  })  => HiWrap(id: id ?? this.id, data: data ?? this.data);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, data];

}