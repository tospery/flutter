import 'package:hi_base/src/extension/map.dart';
import 'package:hi_base/src/function.dart';
import 'package:hi_base/src/model/model.dart';

/// 与用户关联的本地配置
class HiProfile extends HiModel {
  const HiProfile({super.id});

  factory HiProfile.fromJson(dynamic data) =>
      HiProfile(id: tryJSON(data)?.stringValue('id'));

  @override
  Map<String, dynamic> toJson() => {'id': id};

  HiProfile copyWith({String? id}) {
    return HiProfile(id: id ?? this.id);
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
