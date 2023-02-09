import 'package:hi_core/hi_core.dart';

class HiSimple extends HiModel {
  final String? title;
  final String? subTitle;
  final String? detail;
  final String? icon;
  final String? color;
  final double? height;
  final bool? indicated;
  final bool? separated;

  bool get isSpace => id == null || id == 'space';
  bool get isButton => id == 'button';
  bool get hasIndicator => !isSpace && !isButton ? indicated ?? true : false;
  bool get hasSeparator => !isSpace && !isButton ? separated ?? true : false;

  const HiSimple({
    super.id,
    this.title,
    this.subTitle,
    this.detail,
    this.icon,
    this.color,
    this.height,
    this.indicated,
    this.separated,
  });

  factory HiSimple.fromJson(Map<String, dynamic> json) => HiSimple(
    id: json.stringForKey('id'),
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
    'title': title,
    'subTitle': subTitle,
    'detail': detail,
    'icon': icon,
    'color': color,
    'height': height,
    'indicated': indicated,
    'separated': separated,
  };

  HiSimple copyWith({
    String? id,
    String? title,
    String? subTitle,
    String? detail,
    String? icon,
    String? color,
    double? height,
    bool? indicated,
    bool? separated,
  }) {
    return HiSimple(
      id: id ?? this.id,
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
  List<Object?> get props =>  [
    id, icon, title, subTitle, detail,
    color, height, indicated, separated,
  ];
}