import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/extension/map.dart';
import 'package:hi_flutter/src/model/hi_model.dart';

class HiSimple extends HiModel {
  final double? height;
  final String? color;
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? detail;
  final bool? indicated;
  final bool? separated;

  // static const String spaceId = 'space';
  // static const String buttonId = 'button';

  bool get isSpace => id == null || id == 'space';
  bool get isButton => id == 'button';
  bool get hasIndicator => !isSpace && !isButton ? indicated ?? true : false;
  bool get hasSeparator => !isSpace && !isButton ? separated ?? true : false;

  const HiSimple({
    super.id,
    this.height,
    this.color,
    this.icon,
    this.title,
    this.subTitle,
    this.detail,
    this.indicated,
    this.separated,
  });

  factory HiSimple.fromJson(Map<String, dynamic> json) => HiSimple(
        id: json.stringForKey('id'),
        height: json.doubleForKey('height'),
        color: json.stringForKey('color'),
        icon: json.stringForKey('icon'),
        title: json.stringForKey('title'),
        subTitle: json.stringForKey('subTitle'),
        detail: json.stringForKey('detail'),
        indicated: json.boolForKey('indicated'),
        separated: json.boolForKey('separated'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'icon': icon,
        'title': title,
        'subTitle': subTitle,
        'detail': detail,
        'color': color,
        'height': height,
        'indicated': indicated,
        'separated': separated,
      };

  HiSimple copyWith({
    String? id,
    HiSimpleStyle? style,
    double? height,
    String? color,
    String? icon,
    String? title,
    String? subTitle,
    String? detail,
    bool? indicated,
    bool? separated,
  }) {
    return HiSimple(
      id: id ?? this.id,
      height: height ?? this.height,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      detail: detail ?? this.detail,
      indicated: indicated ?? this.indicated,
      separated: separated ?? this.separated,
    );
  }

  @override
  List<Object?> get props =>
      [id, icon, title, subTitle, detail, color, height, indicated, separated];
}
