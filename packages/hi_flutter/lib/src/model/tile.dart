import 'package:hi_core/hi_core.dart';

class HiTile extends HiModel {
  final int? style;
  final String? title;
  final String? subTitle;
  final String? detail;
  final String? icon;
  final String? color;
  final double? height;
  final bool? indicated;
  final bool? separated;

  const HiTile({
    super.id,
    this.style,
    this.title,
    this.subTitle,
    this.detail,
    this.icon,
    this.color,
    this.height,
    this.indicated,
    this.separated,
  });

  factory HiTile.fromJson(Map<String, dynamic> json) => HiTile(
        id: json.stringForKey('id'),
        style: json.intForKey('style'),
        title: json.stringForKey('title'),
        subTitle: json.stringForKey('subTitle'),
        detail: json.stringForKey('detail'),
        icon: json.stringForKey('icon'),
        color: json.stringForKey('color'),
        height: json.doubleForKey('height'),
        indicated: json.boolForKey('indicated'),
        separated: json.boolForKey('separated'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'style': style,
        'title': title,
        'subTitle': subTitle,
        'detail': detail,
        'icon': icon,
        'color': color,
        'height': height,
        'indicated': indicated,
        'separated': separated,
      };

  HiTile copyWith({
    String? id,
    int? style,
    String? title,
    String? subTitle,
    String? detail,
    String? icon,
    String? color,
    double? height,
    bool? indicated,
    bool? separated,
  }) {
    return HiTile(
      id: id ?? this.id,
      style: style ?? this.style,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      detail: detail ?? this.detail,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      height: height ?? this.height,
      indicated: indicated ?? this.indicated,
      separated: separated ?? this.separated,
    );
  }

  @override
  List<Object?> get props => [
        id,
        style,
        icon,
        title,
        subTitle,
        detail,
        color,
        height,
        indicated,
        separated,
      ];
}
