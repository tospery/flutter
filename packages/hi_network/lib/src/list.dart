import 'package:hi_core/hi_core.dart';

class HiList<T> extends HiModel {
  final bool? hasNext;
  final int? count;
  final List<T>? items;

  @override
  bool get isValid => items?.isNotEmpty ?? false;

  const HiList({
    this.hasNext,
    this.count,
    this.items,
  });

  factory HiList.fromJson(Map<String, dynamic> json) => HiList(
    hasNext: hiBool(json.valueForKeys(['has_next', '!over'])),
    count: hiInt(json.valueForKeys(['count', 'total'])),
    //   items: json.valueForKeys(['items', 'datas']) as List<T>?,
    items: (json.valueForKeys(['items', 'datas']) as List?)?.cast<T>(),
  );

  @override
  Map<String, dynamic> toJson() => {
    'has_next': hasNext,
    'count': count,
    'items': items,
  };

  HiList copyWith({
    bool? hasNext,
    int? count,
    List<T>? items,
  }) => HiList(
    hasNext: hasNext ?? this.hasNext,
    count: count ?? this.count,
    items: items ?? this.items,
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [hasNext, count, items];
}