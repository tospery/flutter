import 'package:hi_core/hi_core.dart';

class HiTab extends HiModel {
  final String? title;
  final int? style;

  const HiTab({
    super.id,
    this.title,
    this.style,
  });

  factory HiTab.fromJson(dynamic data) => HiTab(
        id: tryJSON(data)?.stringValue('id'),
        title: tryJSON(data)?.stringValue('title'),
        style: tryJSON(data)?.intValue('style'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'style': style,
      };

  HiTab copyWith({
    String? id,
    String? title,
    int? style,
  }) =>
      HiTab(
        id: id ?? this.id,
        title: title ?? this.title,
        style: style ?? this.style,
      );

  @override
  List<Object?> get props => [id, title, style];
}
