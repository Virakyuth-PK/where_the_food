import 'package:moor/moor.dart';

class Users extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();

  TextColumn get userId => text()();

  TextColumn get fullName => text()();

  TextColumn get dateOfBirth => text()();

  TextColumn get token => text()();
}
