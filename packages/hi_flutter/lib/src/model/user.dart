import 'package:hi_core/hi_core.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/core/constant.dart';
import 'package:hi_flutter/src/model/storable.dart';

class HiUser extends HiStorable {
  final String? username;
  final String? password;

  @override
  bool get isValid =>
      (id?.isNotEmpty ?? false) || (username?.isNotEmpty ?? false);

  const HiUser({
    super.id,
    this.username,
    this.password,
  });

  factory HiUser.fromJson(Map<String, dynamic> json) => HiUser(
    id: json.stringForKey('id'),
    username: json.stringForKey('username'),
    password: json.stringForKey('password'),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
  };

  HiUser copyWith({
    String? id,
    String? username,
    String? password,
  }) {
    return HiUser(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  void store({bool isReactive = false}) {
    super.store(isReactive: isReactive);
    if (isReactive) {
      Get.replace<HiUser>(this);
      eventBus.fire(this);
    }
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, username, password];
  }
}