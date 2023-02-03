import 'dart:io';
import 'package:sqflite/sqflite.dart';

class HiDbManager {
  static const _version = 1;

  static Database? _db;

  static init() async {
    var path = await getDatabasesPath();
    String? userid;
    // if (hiGetUseridFunc != null) {
    //   userid = hiGetUseridFunc!();
    // }
    userid ??= 'unlogged.db';

    if (Platform.isIOS) {
      path += '/$userid';
    } else {
      path += userid;
    }
    _db = await openDatabase(path, version: _version,
        onCreate: (database, version) {
      // log('数据库已创建->$path', tag: HiLogTag.cache);
    });
  }

  static Future<bool> isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _db?.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res?.isNotEmpty ?? false;
  }

  static Future<Database> getCurrentDatabase() async {
    if (_db == null) {
      await init();
    }
    return _db!;
  }

  static Future<void> close() async {
    _db?.close();
    _db = null;
  }
}
