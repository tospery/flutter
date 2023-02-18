import 'package:hi_core/hi_core.dart';

class HiSpace extends HiModel {
  final int? style;
  final String? color;
  final double? height;

  static const defaultHeight = 15.0;

  const HiSpace({
    this.style,
    this.color,
    this.height,
  });

  factory HiSpace.fromJson(Map<String, dynamic> json) => HiSpace(
        style: json.intForKey('style'),
        color: json.stringForKey('color'),
        height: json.doubleForKey('height'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'style': style,
        'color': color,
        'height': height,
      };

  HiSpace copyWith({
    int? style,
    String? color,
    double? height,
  }) {
    return HiSpace(
      style: style ?? this.style,
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [style, color, height];
}
