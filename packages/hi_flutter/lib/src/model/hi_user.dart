import 'package:get/get.dart';
import '../core/constant.dart';
import '../extension/map.dart';
import '../utils/hi_user_notifier.dart';
import 'hi_model.dart';

// Counter _counter=new Counter()
HiUserNotifier userNotifier = HiUserNotifier();

class HiUser extends HiModel {
  // final bool isLogined;
  final String? username;
  final String? password;
  // final String? avatar;
  // final String? phone;
  // final String? token;

  const HiUser({
    super.id,
    // this.isLogined = false,
    this.username,
    this.password,
    // this.avatar,
    // this.phone,
    // this.token,
  });

  @override
  bool get isValid =>
      (id?.isNotEmpty ?? false) || (username?.isNotEmpty ?? false);

  factory HiUser.fromJson(Map<String, dynamic> json) => HiUser(
        id: json.stringForKey('id'),
        // isLogined: json.boolForKey('isLogined') ?? false,
        username: json.stringForKey('username'),
        password: json.stringForKey('password'),
        // avatar: json.stringForKey('avatar'),
        // phone: json.stringForKey('phone'),
        // token: json.stringForKey('token'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        // 'isLogined': isLogined,
        'username': username,
        'password': password,
        // 'avatar': avatar,
        // 'phone': phone,
        // 'token': token,
      };

  HiUser copyWith({
    String? id,
    // bool? isLogined,
    String? username,
    String? password,
  }) {
    return HiUser(
      id: id ?? this.id,
      // isLogined: isLogined ?? this.isLogined,
      username: username ?? this.username,
      password: password ?? this.password,
      // avatar: password ?? this.avatar,
      // phone: phone ?? this.phone,
      // token: token ?? this.token,
    );
  }

  @override
  void save({bool isReactive = false}) {
    super.save(isReactive: isReactive);
    if (isReactive) {
      Get.replace<HiUser>(this);
      eventBus.fire(this);
    }
  }

  // @override
  // save() {
  //   super.save();
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, username, password];
  }
}
