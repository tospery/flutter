import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../extension/map.dart';
import '../extension/object.dart';
import 'package:hi_core/src/datatype.dart';
import 'package:hi_core/src/logger.dart';

class HiModel extends Equatable {
  final String? id;

  bool get isValid => id?.isNotEmpty ?? false;

  const HiModel({this.id});

  factory HiModel.fromJson(Map<String, dynamic> json) => HiModel(
        id: json.value<String>('id'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  Widget? get separator => null;
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => null;

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [id];
}
