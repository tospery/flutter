import 'package:hi_base/src/extension/map.dart';
import 'package:hi_base/src/function.dart';
import 'package:hi_base/src/model/model.dart';

class HiUser extends HiModel {
  final String? username;
  final String? password;

  @override
  bool get isValid =>
      (id?.isNotEmpty ?? false) || (username?.isNotEmpty ?? false);

  const HiUser({super.id, this.username, this.password});

  factory HiUser.fromJson(dynamic data) => HiUser(
    id: tryJSON(data)?.stringValue('id'),
    username: tryJSON(data)?.stringValue('username'),
    password: tryJSON(data)?.stringValue('password'),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
  };

  HiUser copyWith({String? id, String? username, String? password}) => HiUser(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
  );

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
    return [id, username, password];
  }
}
