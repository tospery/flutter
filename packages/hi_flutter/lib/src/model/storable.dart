import 'package:hi_core/hi_core.dart';
import 'package:hi_cache/hi_cache.dart';

class HiStorable extends HiModel {

  const HiStorable({
    super.id,
  });

  factory HiStorable.fromJson(Map<String, dynamic> json) =>
      HiStorable(
        id: json.stringForKey('id'),
      );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
  };

  HiStorable copyWith({
    String? id,
  }) {
    return HiStorable(
      id: id ?? this.id,
    );
  }

  void store({bool isReactive = false}) {
    var key = typeName.toLowerCase();
    log('存储key = $key');
    var value = toJson().toJsonString();
    log('存储value = $value');
    HiCache.shared().set(key, value);
  }

  // static dynamic fetch() {
  //   return null;
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id];

}