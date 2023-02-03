import 'package:hi_flutter/hi_flutter.dart';

class HiDataList<T> extends HiModel {
  final bool? hasNext;
  final int? count;
  final List<T>? items;

  @override
  bool get isValid => hasNext != null || count != null || items != null;

  const HiDataList({
    this.hasNext,
    this.count,
    this.items,
  });

  factory HiDataList.fromJson(Map<String, dynamic> json) => HiDataList(
        hasNext: hiBool(json.valueForKeys(['has_next', '!over'])),
        count: hiInt(json.valueForKeys(['count', 'total'])),
        items: json.valueForKeys(['items', 'datas']) as List<T>?,
      );

  @override
  Map<String, dynamic> toJson() => {
        'has_next': hasNext,
        'count': count,
        'items': items,
      };

  HiDataList copyWith({
    bool? hasNext,
    int? count,
    List<T>? items,
  }) {
    return HiDataList(
      hasNext: hasNext ?? this.hasNext,
      count: count ?? this.count,
      items: items ?? this.items,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [hasNext, count, items];
}
