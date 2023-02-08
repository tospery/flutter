import 'package:hi_cache/hi_cache.dart';

class Plan extends HiModel {
  final String? name;
  final int? space;

  const Plan({
    super.id,
    this.name,
    this.space,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json.stringForKey('id'),
    name: json.stringForKey('name'),
    space: json.intForKey('space'),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'space': space,
  };

  Plan copyWith({
    String? id,
    String? name,
    int? space,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      space: space ?? this.space,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, space];
}
