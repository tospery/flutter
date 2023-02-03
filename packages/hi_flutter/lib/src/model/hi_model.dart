import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hi_flutter/src/cache/cache.dart';
import 'package:hi_flutter/src/extension/map.dart';
import 'package:hi_flutter/src/extension/object.dart';
import '../core/logger.dart';
import 'hi_simple.dart';

class HiModel extends Equatable {
  final String? id;

  bool get isValid => id?.isNotEmpty ?? false;

  Widget get separator {
    if (this is HiSimple) {
      return (this as HiSimple).hasSeparator ? const Divider() : Container();
    }
    return Container();
  }

  const HiModel({this.id});

  factory HiModel.fromJson(Map<String, dynamic> json) => HiModel(
        id: json.stringForKey('id'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  // save() {
  //   var aaa = runtimeType.toString();
  //   var bbb = typeName;
  //   log(aaa);
  //   log(bbb);
  //   HiCache.shared().setString(toJson().toJsonString(), HiKey.configuration);
  //   // Get.lazyPut<HiConfiguration>(() => this);
  // }
  void save({
    bool isReactive = false,
  }) {
    var key = typeName.toLowerCase();
    log('缓存key = $key');
    HiCache.shared().setString(key, toJson().toJsonString());
  }

  static dynamic fetch() {
    // var aaa = type
    // HiCache.shared().get(typeName.toLowerCase());
  }

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
