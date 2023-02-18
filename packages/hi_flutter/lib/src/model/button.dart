import 'package:hi_core/hi_core.dart';

class HiButton extends HiModel {
  final int? style;
  final String? icon;
  final String? title;
  final double? height;
  final String? titleColor;
  final String? backgroundColor;

  const HiButton({
    super.id,
    this.icon,
    this.style,
    this.title,
    this.height,
    this.titleColor,
    this.backgroundColor,
  });

  factory HiButton.fromJson(Map<String, dynamic> json) => HiButton(
        id: json.stringForKey('id'),
        style: json.intForKey('style'),
        height: json.doubleForKey('height'),
        title: json.stringForKey('title'),
        icon: json.stringForKey('icon'),
        titleColor: json.stringForKey('titleColor'),
        backgroundColor: json.stringForKey('backgroundColor'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'style': style,
        'title': title,
        'icon': icon,
        'height': height,
        'titleColor': titleColor,
        'backgroundColor': backgroundColor,
      };

  HiButton copyWith({
    String? id,
    int? style,
    String? title,
    String? icon,
    double? height,
    String? titleColor,
    String? backgroundColor,
  }) {
    return HiButton(
      id: id ?? this.id,
      style: style ?? this.style,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      height: height ?? this.height,
      titleColor: titleColor ?? this.titleColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object?> get props =>
      [id, style, title, icon, height, titleColor, backgroundColor];
}
