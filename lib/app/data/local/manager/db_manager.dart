import 'dart:io';

import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';

import '../table/user_table.dart';

part 'db_manager.g.dart';

openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
@UseMoor(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  int get schemaVersion => 1;

  // Add user
  Future insertUser(User user) async {
    Logger().i(user);
    return await into(users).insertOnConflictUpdate(user);
  }

  // Get user
  Future getUser() async {
    var result = await select(users).getSingleOrNull();
    return result;
  }

  // Delete user
  Future deleteUser(User user) async {
    Logger().i(user);
    return await delete(users).delete(user);
  }

  // Update user
  Future updateUser(User user) async {
    Logger().i(user);
    return await update(users).replace(user);
  }

}