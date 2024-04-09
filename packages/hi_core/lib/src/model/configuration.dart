import 'package:hi_core/src/constant.dart';
import 'package:hi_core/src/model/model.dart';
import 'package:hi_core/src/extension/map.dart';

/// 与用户关联的本地配置
class HiConfiguration extends HiModel {

  const HiConfiguration({
    super.id,
  });

  factory HiConfiguration.fromJson(Map<String, dynamic> json) =>
      HiConfiguration(
        id: json.stringValue('id'),
      );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
  };

  HiConfiguration copyWith({
    String? id,
  }) {
    return HiConfiguration(
      id: id ?? this.id,
    );
  }

  // @override
  // void store({bool isReactive = false}) {
  //   super.store(isReactive: isReactive);
  //   if (isReactive) {
  //     Get.replace<HiConfiguration>(this);
  //     eventBus.fire(this);
  //   }
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id];
}