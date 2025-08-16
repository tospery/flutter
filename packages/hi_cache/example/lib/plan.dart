import 'package:hi_cache/hi_cache.dart';

class Plan extends HiModel {
  final int? space;

  const Plan({
    super.id,
    this.space,
  });

  factory Plan.fromJson(dynamic json) => Plan(
        id: tryJSON(json)?.stringValue('id'),
        space: tryJSON(json)?.intValue('space'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'space': space,
      };

  Plan copyWith({
    String? id,
    String? name,
    int? space,
  }) {
    return Plan(
      id: id ?? this.id,
      space: space ?? this.space,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, space];
}
