import 'package:hi_core/hi_core.dart';

class HiText extends HiModel {
  final String content;
  final List<String>? links;

  const HiText(
    this.content, {
    this.links,
  });

  factory HiText.fromJson(Map<String, dynamic> json) => HiText(
        json.stringForKey('content') ?? '',
        links: json.listForKey<String>('links'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'content': content,
        'links': links,
      };

  HiText copyWith({
    String? content,
    List<String>? links,
  }) {
    return HiText(
      content ?? this.content ?? '',
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [content, links];
}
