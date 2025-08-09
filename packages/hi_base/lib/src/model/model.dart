import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hi_base/src/datatype.dart';
import 'package:hi_base/src/function.dart';
import 'package:hi_base/src/extension/map.dart';

class HiModel extends Equatable {
  final String? id;

  bool get isValid => id?.isNotEmpty ?? false;

  const HiModel({this.id});

  factory HiModel.fromJson(dynamic data) =>
      HiModel(id: tryJSON(data)?.stringValue('id'));

  Map<String, dynamic> toJson() => {'id': id};

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id];

  Widget? get separator => const Divider();
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => null;
}
