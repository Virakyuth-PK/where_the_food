import 'package:moor/moor.dart';

class Carts extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();

  TextColumn get itemId => text()();

  TextColumn get name => text()();

  TextColumn get image => text()();

  TextColumn get price => text()();

  TextColumn get category => text()();

  IntColumn get qty => integer()();
}
