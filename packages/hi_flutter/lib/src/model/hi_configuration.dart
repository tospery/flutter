import 'package:hi_flutter/hi_flutter.dart';

/// 与用户关联的本地配置
class HiConfiguration extends HiModel {
  final List<String>? codeKeys;
  final List<String>? messageKeys;
  final List<String>? dataKeys;

  const HiConfiguration({
    super.id,
    this.codeKeys,
    this.messageKeys,
    this.dataKeys,
  });

  factory HiConfiguration.fromJson(Map<String, dynamic> json) =>
      HiConfiguration(
        id: json.stringForKey('id'),
        codeKeys: json.listForKey<String>('codeKeys'),
        messageKeys: json.listForKey<String>('messageKeys'),
        dataKeys: json.listForKey<String>('dataKeys'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'codeKeys': codeKeys,
        'messageKeys': messageKeys,
        'dataKeys': dataKeys,
      };

  HiConfiguration copyWith({
    String? id,
    List<String>? codeKeys,
    List<String>? messageKeys,
    List<String>? dataKeys,
  }) {
    return HiConfiguration(
      id: id ?? this.id,
      codeKeys: codeKeys ?? this.codeKeys,
      messageKeys: messageKeys ?? this.messageKeys,
      dataKeys: dataKeys ?? this.dataKeys,
    );
  }

  @override
  void save({bool isReactive = false}) {
    super.save(isReactive: isReactive);
    if (isReactive) {
      Get.replace<HiConfiguration>(this);
      eventBus.fire(this);
    }
  }

  // save() {
  //   var aaa = runtimeType.toString();
  //   var bbb = typeName;
  //   log(aaa);
  //   log(bbb);
  //   HiCache.shared().setString(toJson().toJsonString(), HiKey.configuration);
  //   // Get.lazyPut<HiConfiguration>(() => this);
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, codeKeys, messageKeys, dataKeys];
}
