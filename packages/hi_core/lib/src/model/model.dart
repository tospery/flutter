import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../extension/map.dart';
import '../extension/object.dart';

class HiModel extends Equatable {
  final String? id;

  bool get isValid => id?.isNotEmpty ?? false;

  const HiModel({this.id});

  factory HiModel.fromJson(Map<String, dynamic> json) => HiModel(
        id: json.stringForKey('id'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  // void save({
  //   bool isReactive = false,
  // }) {
  //   var key = typeName.toLowerCase();
  //   log('缓存key = $key');
  //   HiCache.shared().setString(key, toJson().toJsonString());
  // }

  // static dynamic fetch() {
  //   // var aaa = type
  //   // HiCache.shared().get(typeName.toLowerCase());
  // }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [id];
}
