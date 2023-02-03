import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'db_manager.dart';

// class HiDbProvider<M extends HiModel> {
class HiDbProvider<M> {
  final String columnId = '_id';
  final String columnKey = 'key';
  final String columnData = 'data';

  bool isTableExits = false;

  int? id;
  String? key;
  String? data;

  HiDbProvider();

  String get tableName => M.toString();

  String get tableSqlString {
    return '''
create table $tableName (
  $columnId integer primary key autoincrement,
  $columnKey text not null,
  $columnData text not null)
''';
  }

  Map<String, dynamic> toMap(String key, String data) {
    Map<String, dynamic> map = {columnKey: key, columnData: data};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  HiDbProvider.fromMap(Map map) {
    id = map[columnId];
    key = map[columnKey];
    data = map[columnData];
  }

  Future<bool> store(String key, String data) async {
    Database db = await getDataBase();
    var provider = await _getProvider(db, key);
    if (provider != null) {
      await db.delete(tableName, where: '$columnKey = ?', whereArgs: [key]);
    }
    var result = await db.insert(tableName, toMap(key, data));
    return result != 0;
  }

  // Future<dynamic> fetch(String key) async {
  //   Database db = await getDataBase();
  //   var provider = await _getProvider(db, key);
  //   var string = provider?.data;
  //   if (string?.isEmpty ?? true) {
  //     return null;
  //   }
  //   return await compute(HiConvert.toJson, string!);
  // }

  Future<HiDbProvider?> _getProvider(Database db, String? key) async {
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: [columnId, columnKey, columnData],
        where: '$columnKey = ?',
        whereArgs: [key]);
    if (maps.isNotEmpty) {
      return HiDbProvider.fromMap(maps.first);
    }
    return null;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  Future<void> prepare(name, String? createSql) async {
    isTableExits = await HiDbManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await HiDbManager.getCurrentDatabase();
      return await db.execute(createSql!);
    }
  }

  @mustCallSuper
  Future<Database> open() async {
    if (!isTableExits) {
      await prepare(tableName, tableSqlString);
    }
    return await HiDbManager.getCurrentDatabase();
  }
}
