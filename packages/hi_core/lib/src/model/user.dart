import 'package:hi_core/src/constant.dart';
import 'package:hi_core/src/model/model.dart';
import 'package:hi_core/src/extension/map.dart';

class HiUser extends HiModel {
  final String? username;
  final String? password;
  final String? avatar;

  @override
  bool get isValid =>
      (id?.isNotEmpty ?? false) || (username?.isNotEmpty ?? false);

  const HiUser({
    super.id,
    this.username,
    this.password,
    this.avatar,
  });

  factory HiUser.fromJson(Map<String, dynamic> json) => HiUser(
    id: json.stringForKey('id'),
    username: json.stringForKey('username'),
    password: json.stringForKey('password'),
    avatar: json.stringForKey('avatar'),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
    'avatar': avatar,
  };

  HiUser copyWith({
    String? id,
    String? username,
    String? password,
    String? avatar,
  }) {
    return HiUser(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
    );
  }

  // @override
  // void store({bool isReactive = false}) {
  //   super.store(isReactive: isReactive);
  //   if (isReactive) {
  //     Get.replace<HiUser>(this);
  //     eventBus.fire(this);
  //   }
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, username, password, avatar];
  }
}